defmodule EHelix.Helpers do
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

  def log(inserted, id, message) do
    %{
      inserted_at: inserted,
      log_id: id,
      message: message
    }
  end
end
