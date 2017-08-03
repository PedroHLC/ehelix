defmodule EHelixWeb.RequestsChannel do
  use EHelixWeb, :channel

  def join("requests", _message, socket) do
    {:ok, socket}
  end

  def handle_in("account.logout", _, socket) do
    Emulator.requests(:logout)
    EHelixWeb.Endpoint.broadcast("socket", "disconnect", %{})
    {:stop, :shutdown, socket}
  end

  def handle_in(any, params, socket) do
    {:noreply, socket}
  end
end
