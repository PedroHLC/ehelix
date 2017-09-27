defmodule EHelixWeb.Socket do
  use Phoenix.Socket

  alias EHelix.Emulator, as: Emulator
  alias EHelix.Helpers, as: Helpers

  channel "account:*", EHelixWeb.AccountChannel
  channel "server:*", EHelixWeb.ServerChannel
  channel "requests", EHelixWeb.RequestsChannel

  transport :websocket, Phoenix.Transports.WebSocket

  def connect(_params, socket) do
    Emulator.set(initialize())

    {:ok, socket}
  end

  def initialize do
    %{
      account:
        Helpers.default_account(),
      meta:
        %{},
    }
  end

  def broadcast(socket, event, data \\ %{}) do
    EHelixWeb.Endpoint.broadcast(id(socket), event, data)
  end

  def id(_socket), do: "socket"
end
