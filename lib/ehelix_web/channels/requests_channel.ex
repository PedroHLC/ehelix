defmodule EHelixWeb.RequestsChannel do
  use EHelixWeb, :channel

  def join("requests", _message, socket) do
    {:ok, socket}
  end

  def handle_in("account.logout", _, socket) do
    EHelixWeb.Socket.broadcast(socket, "disconnect")
    {:stop, :shutdown, socket}
  end

  def handle_in(_, _, socket) do
    {:noreply, socket}
  end

  defp notify(data) do
    EHelixWeb.Endpoint.broadcast("requests", "event", data)
  end
end
