defmodule EHelixWeb.Socket do
  use Phoenix.Socket

  channel "account:*", EHelixWeb.AccountChannel
  channel "server:*", EHelixWeb.ServerChannel
  channel "requests", EHelixWeb.RequestsChannel

  transport :websocket, Phoenix.Transports.WebSocket

  def connect(_params, socket) do
    {:ok, socket}
  end

  def id(_socket), do: "socket"
end
