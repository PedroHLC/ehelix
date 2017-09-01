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
        default_account(),

      meta:
        %{},

      servers:
        %{
          gateways:
            [
              %{
                id: "gate1",
                name: "Test",
                nips: [["::", "1.2.3.4"]],
                coordinates: 0.0,
                logs:
                  [
                    log(:rand.uniform(10000), "131agdgd313", "loadgadgdagdgg3"),
                    log(:rand.uniform(10000), "w413agdag531", "adgdadagad"),
                    log(:rand.uniform(10000), "adgvxvad", "logagagagagxgad4")
                  ],
                tunnels: [],
                filesystem: default_filesystem(),
                processes: %{},
                endpoints: []
              },
              %{
                id: "gate2",
                name: "Testfaf",
                coordinates: 0.0,
                nips: [["::", "5.6.7.7"]],
                logs:
                  [
                    log(:rand.uniform(10000), "131313", "loadgg3"),
                    log(:rand.uniform(10000), "w413531", "loagadgg4"),
                    log(:rand.uniform(10000), "2423315135", "logagagad4")
                  ],
                tunnels: [],
                filesystem: default_filesystem(),
                processes: %{},
                endpoints: []
              }
            ],
          endpoints:
            []
        }
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

  def default_filesystem do
    [
      %{
        id: "001",
        name: "home",
        children: [
          %{
            id: "002",
            name: "root",
            children: [
              %{
                id: "003",
                name: "Firewall",
                modules: [
                  %{name: "Active", version: 1},
                  %{name: "Passive", version: 2}
                ],
                version: 2,
                size: 900000,
                extension: "fwl"
              },
              %{
                id: "004",
                name: "Virus",
                modules: [
                  %{name: "Active", version: 1}
                ],
                version: 2,
                size: 752000,
                extension: "spam"
              }
            ]
          }
        ]
      }
    ]
  end

  def default_account do
    %{
      email: "renato@hackerexperince.com",
      database: %{
        servers: [
          %{
            netid: "::",
            ip: "153.249.31.179",
            password: "WhenYouWereHereBefore",
            label: "Creep 1",
            notes: "Weirdo",
            viruses: [
              %{id: "dummyVirus1", filename: "GrandpaChair.mlw", version: 2.1},
              %{id: "dummyThrojan1", filename: "GrandmaTshirt.mlw", version: 2.0}
            ],
            active: %{id: "dummyThrojan1",since: 1498589047000},
            type: "player"
          },
          %{
            netid: "::",
            ip: "153.249.31.169",
            password: "CouldntLookYouInTheEyes",
            label: "Creep 2",
            viruses: [
              %{id: "dummyVirus2", filename: "GrandpaChair.mlw", version: 2.1},
              %{id: "dummyThrojan2", filename: "GrandmaTshirt.mlw", version: 2.0}
            ],
            active: %{id: "dummyThrojan2",since: 1498589047000},
            type: "player"
          }
        ],
        accounts: [],
        wallets: []
      },
      dock: ["browser", "explorer", "logvw", "taskmngr", "db", "connmngr", "bouncemngr", "finances", "hebamp", "ctrlpnl", "srvsgrs", "lanvw", "emails"],
      servers: ["gate1", "gate2"],
      bounces: %{
        aaaa: %{
          name: "Pwned -> Rekt",
          path: [
            %{netid: "::", ip: "153.249.31.179"},
            %{netid: "::", ip: "143.239.31.169"}
          ]
        },
        bbbb: %{
          name: "Rekt -> Pwned",
          path: [
            %{netid: "::", ip: "143.239.31.169"},
            %{netid: "::", ip: "153.249.31.179"}
          ]
        }
      },
      inventory: %{
        i001: %{
          type: "ram",
          size: 512000000
        }
      }
    }
  end
end
