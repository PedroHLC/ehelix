defmodule EHelixWeb.AccountChannel do
  use EHelixWeb, :channel

  def join("account:" <> id, _message, socket) do
    case Emulator.notifier? do
      nil ->
        nil
      pid ->
        send(pid, :shutdown)
    end

    pid = spawn_link(fn -> notify_loop(id) end)
    Emulator.notifier(pid)

    {:ok, socket}
  end

  defp notify(id, data) do
    EHelixWeb.Endpoint.broadcast("account:" <> id, "event", data)
  end

  def handle_in("account.bootstrap", _, socket) do
    data = Emulator.account(:bootstrap)
    reply =
      %{
        data: data,
      }

    {:reply, {:ok, reply}, socket}
  end

  def handle_in(_, _, socket) do
    {:noreply, socket}
  end

  defp notify_loop(id) do
    receive do
      :shutdown ->
        :ok
    after
      3_000 ->
        event =
          %{
            event:
              "ping",
            data:
              %{ hello: "word" }
            }

        notify(id, event)
        notify_loop(id)
    end
  end
end
