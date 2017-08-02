defmodule EHelixWeb.AccountChannel do
  use Phoenix.Channel

  def join("account:" <> id, _message, socket) do
    {:ok, socket}
  end
end
