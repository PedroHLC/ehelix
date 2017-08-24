defmodule EHelixWeb.Socket do
  use Phoenix.Socket

  alias EHelix.Emulator, as: Emulator

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
        %{
          email: "renato@hackerexperience.com",
          picture: "https://avatars1.githubusercontent.com/u/5695464?v=4&s=460",
          bounces: nil,
          database: nil,
          inventory: nil,
          servers: ["gate1", "gate2"],
          activeGateway: "gate1"
        },

      meta:
        %{},

      servers:
        [
          %{
            id: "gate1",
            name: "Test",
            coordinates: 0.0,
            nip: ["::", "1.2.3.4"],
            logs:
              [
                log(:rand.uniform(10000), "131agdgd313", "loadgadgdagdgg3"),
                log(:rand.uniform(10000), "w413agdag531", "adgdadagad"),
                log(:rand.uniform(10000), "adgvxvad", "logagagagagxgad4")
              ],
            tunnels: %{},
            filesystem: %{},
            processes: %{}
          },
          %{
            id: "gate2",
            name: "Testfaf",
            coordinates: 0.0,
            nip: ["::", "5.6.7.7"],
            logs:
              [
                log(:rand.uniform(10000), "131313", "loadgg3"),
                log(:rand.uniform(10000), "w413531", "loagadgg4"),
                log(:rand.uniform(10000), "2423315135", "logagagad4")
              ],
            tunnels: %{},
            filesystem: %{},
            processes: %{}
          }
        ]
    }
  end


  def log(inserted, id, message) do
    %{
      inserted_at: inserted,
      log_id: id,
      message: message
    }
  end


  def broadcast(socket, event, data \\ %{}) do
    EHelixWeb.Endpoint.broadcast(id(socket), event, data)
  end

  def id(_socket), do: "socket"
end
