defmodule EHelixWeb.ServerChannel do
  use EHelixWeb, :channel


  def join("server:" <> _, _message, socket) do
    {:ok, socket}
  end

  defp notify(id, data) do
    EHelixWeb.Endpoint.broadcast("server:" <> id, "event", data)
  end
end
