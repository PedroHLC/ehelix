defmodule EHelixWeb.AccountChannel do
  use EHelixWeb, :channel

  def join("account:" <> _, _message, socket) do
    {:ok, socket}
  end

  def handle_in("account.bootstrap", _, socket) do
    state = Emulator.get

    response =
      %{
        data:
          %{
            account:
              state.account,
            meta: %{},
            servers:
              state.servers
          }
      }
    {:reply, {:ok, response}, socket}
  end

  def handle_in(_, _, socket) do
    {:noreply, socket}
  end

  defp notify(id, data) do
    EHelixWeb.Endpoint.broadcast("account:" <> id, "event", data)
  end
end
