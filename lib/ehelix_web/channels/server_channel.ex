defmodule EHelixWeb.ServerChannel do
  use Phoenix.Channel

  def join("server:" <> id, _message, socket) do
    {:ok, socket}
  end
end
