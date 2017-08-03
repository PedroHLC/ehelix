defmodule EHelixWeb.AccountChannel do
  use EHelixWeb, :channel

  def join("account:" <> _, _message, socket) do
    {:ok, socket}
  end
end
