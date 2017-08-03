defmodule EHelixWeb.AccountChannel do
  use EHelixWeb, :channel

  def join("account:" <> id, _message, socket) do
    pid = spawn(fn -> notify_loop(id) end)
    Emulator.account({:set_notifier, pid})

    {:ok, socket}
  end

  defp notify(id, data) do
    EHelixWeb.Endpoint.broadcast("account:" <> id, "event", data)
  end

  defp notify_loop(id) do
    receive do
      :shutdown ->
        :ok
    after
      1_000 ->
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
