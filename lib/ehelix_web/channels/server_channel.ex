defmodule EHelixWeb.ServerChannel do
  use EHelixWeb, :channel


  def join("server:" <> _, _message, socket) do
    {:ok, socket}
  end
end
