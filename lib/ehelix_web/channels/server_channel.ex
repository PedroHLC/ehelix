defmodule EHelixWeb.ServerChannel do
  use EHelixWeb, :channel

  alias EHelix.Helpers, as: Helpers

  def bootstrap("192.168.0.1") do
    %{
      data: %{
        id: "gate1",
        name: "Test 1",
        nips: [["::", "192.168.0.1"]],
        coordinates: 0.0,
        endpoints: []
      }
    }
  end

  def bootstrap("192.168.0.2") do
    %{
      data: %{
        id: "gate2",
        name: "Test 2",
        nips: [["::", "192.168.0.2"]],
        coordinates: 0.0,
        endpoints: []
      }
    }
  end

  def bootstrap("8.8.8.8") do
    %{
      data: %{
        id: "remote1",
        name: "Test",
        nips: [["::", "8.8.8.8"]],
        coordinates: 0.0,
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
    }
  end

  def bootstrap("8.8.4.4") do
    %{
      data: %{
        name: "Testfaf",
        coordinates: 0.0,
        nips: [["::", "8.8.4.4"]],
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
    }
  end

  def join("server:" <> topic, _message, socket) do
    [network_id, network_ip] = String.split(topic, "@", parts: 2)

    state =
      Emulator.get()

    pids =
      Map.get(state, :pids, %{})

    pid =
      case Map.get(pids, topic) do
        nil ->
          spawn_link(fn -> notify_loop(topic) end)
        pid ->
          send(pid, {:shutdown, pid})
          spawn_link(fn -> notify_loop(topic) end)
      end

    pids =
      Map.put(pids, topic, pid)

    state =
      Map.put(state, :pids, pids)

    Emulator.set(state)

    {:ok, bootstrap(network_ip), socket}
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
    {:reply, {:ok, bootstrap("1.2.3.4")}, socket}
  end


  def handle_in("file.index", _, socket) do
    {:reply, {:ok, %{data: []}}, socket}
  end

  def handle_in("file.download", _, socket) do
    {:reply, {:error, %{message: "download_self"}}, socket}
  end

  def handle_in("pftp.file.download", _, socket) do
    {:reply, {:error, %{message: "download_self"}}, socket}
  end

  def handle_in("browse", _, socket) do
    response =
      %{
        type: "npc_download_center",
        meta: %{
          password: "",
          nip: ["::", "8.8.4.4"],
          public: [ %{
              id: "somefile",
              name: "ILikeIceCream",
              extension: "exe",
              type: "cracker",
              modules: [ %{
                name: "overflow",
                version: 4
              }]
            } ]
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
