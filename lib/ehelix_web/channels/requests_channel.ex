defmodule EHelixWeb.RequestsChannel do
  use Phoenix.Channel

  def join("requests", _message, socket) do
    {:ok, socket}
  end
end
