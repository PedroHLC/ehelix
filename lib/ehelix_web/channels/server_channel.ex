defmodule EHelixWeb.ServerChannel do
  use EHelixWeb, :channel

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

  def handle_in("file.index", _, socket) do
    {:reply, {:ok, %{data: []}}, socket}
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
    EHelixWeb.Endpoint.broadcast("server:" <> id, "event", data)
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
