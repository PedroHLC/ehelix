defmodule EHelixWeb.AccountChannel do
  use EHelixWeb, :channel

  alias EHelix.Helpers, as: Helpers

  def join("account:" <> _, _message, socket) do
    {:ok, socket}
  end

  def handle_in("bootstrap", _, socket) do
    state = Emulator.get

    response =
      %{
        data:
          %{
            account:
              state.account,
            meta: %{},
            servers:
              %{
                player:
                  [
                    %{
                      id: "gate1",
                      name: "Test",
                      nips: [["::", "1.2.3.4"]],
                      coordinates: 0.0,
                      logs:
                        [
                          Helpers.log(:rand.uniform(10000), "131agdgd313", "loadgadgdagdgg3"),
                          Helpers.log(:rand.uniform(10000), " w413agdag531", "adgdadagad"),
                          Helpers.log(:rand.uniform(10000), "adgvxvad", "logagagagagxgad4")
                        ],
                      tunnels: [],
                      filesystem: Helpers.default_filesystem(),
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
                          Helpers.log(:rand.uniform(10000), "131313", "loadgg3"),
                          Helpers.log(:rand.uniform(10000), "w413531", "loagadgg4"),
                          Helpers.log(:rand.uniform(10000), "2423315135", "logagagad4")
                        ],
                      tunnels: [],
                      filesystem: Helpers.default_filesystem(),
                      processes: %{},
                      endpoints: []
                    }
                  ],
                remote:
                  []
              }
          }
      }

    {:reply, {:ok, response}, socket}
  end

  def handle_in(_, _, socket) do
    {:noreply, socket}
  end

  defp notify(id, data) do
    EHelixWeb.Endpoint.broadcast("account:" <> id, "event", data)
  end
end
