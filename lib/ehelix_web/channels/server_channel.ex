defmodule EHelixWeb.ServerChannel do
  use EHelixWeb, :channel

  alias EHelix.Helpers, as: Helpers

  def join("server:" <> id, _message, socket) do
    state =
      Emulator.get()

    pids =
      Map.get(state, :pids, %{})

    pid =
      case Map.get(pids, id) do
        nil ->
          spawn_link(fn -> notify_loop(id) end)
        pid ->
          send(pid, {:shutdown, pid})
          spawn_link(fn -> notify_loop(id) end)
      end

    pids =
      Map.put(pids, id, pid)

    state =
      Map.put(state, :pids, pids)

    Emulator.set(state)

    {:ok, socket}
  end

  def handle_in("bruteforce", _, socket) do
    data = %{
      type: "Cracker",
      access: %{
        origin_id: "who knows",
        priority: 3,
        usage: %{
          cpu: %{
            percentage: 0.1,
            absolute: 0.1
          },
          mem: %{
            percentage: 0.1,
            absolute: 0.1
          },
          down: %{
            percentage: 0.1,
            absolute: 0.1
          },
          up: %{
            percentage: 0.1,
            absolute: 0.1
          }
        },
        connection_id: "who knows"
      },
      state: "running",
      file: %{
        id: "who knows",
        version: 0.0,
        name: "Who knows"
      },
      progress: %{
        creation_date: 0.0,
        percentage: 0.5,
        completion_date: 0.4
      },
      network_id: "who knows",
      target_ip: "who knows",
      process_id: "who knows"
    }

    spawn(fn ->
      msg = %{
        event: "processes.conclusion",
        data: %{
          process_id: "who knows"
        }
      }
      :timer.sleep(1000)
      notify(socket.topic, msg)
    end)

    {:reply, {:ok, %{data: data}}, socket}
  end

  def handle_in("bootstrap", _, socket) do
    data = %{
      id: "ip",
      name: "Testfaf",
      coordinates: 0.0,
      nips: [["::", "5.6.7.7"]],
      logs:
        [
          Helpers.log(:rand.uniform(10000), "131313", "loadgg3"),
          Helpers.log(:rand.uniform(10000), "w413531", "loagadgg4"),
          Helpers.log(:rand.uniform(10000), "2423315135", "logagagad4")
        ],
      tunnels: [],
      filesystem: Helpers.default_filesystem(),
      processes: %{}
    }

    {:reply, {:ok, %{data: data}}, socket}
  end


  def handle_in("file.index", _, socket) do
    {:reply, {:ok, %{data: []}}, socket}
  end

  def handle_in("browse", _, socket) do
    response =
      %{
        type: "npc_download_center",
        meta: %{
          password: "",
          nip: ["network", "ip"]
        },
        content: %{
          title: "example"
        }
      }

    {:reply, {:ok, %{ data: response}}, socket}
  end

  def handle_in("log.index", _, socket) do
    id =
      case socket.topic do
        "server:" <> id ->
          id

        any ->
          any
      end

    state = Emulator.get

    server =
      state.servers.gateways
      |> Enum.filter(&(&1.id == id))
      |> hd

    {:reply, {:ok, %{data: server.logs}}, socket}
  end

  def handle_in(_, _, socket) do
    {:reply, {:ok, %{data: %{}, status: :not_found}}, socket}
  end

  defp notify(id, data) do
    EHelixWeb.Endpoint.broadcast(id, "event", data)
  end

  defp notify_loop(id) do
    receive do
      {:shutdown, ^id} ->
        :ok
    after
      3_000 ->
        # state = Emulator.get
        # server =
        #   state.servers
        #   |> Enum.filter(&(&1.id == id))
        #   |> hd
        #   event =
        #     %{
        #       event: "logs.changed",
        #       data: server.logs
        #     }
        #   notify(id, event)
        notify_loop(id)
    end
  end
end
