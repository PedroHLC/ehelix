defmodule EHelixWeb.AccountChannel do
  use EHelixWeb, :channel

  alias EHelix.Helpers, as: Helpers

  def bootstrap do
    state = Emulator.get

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
                    server_id: "gate1",
                    network_id: "::",
                    ip: "192.168.0.1"
                  },
                  %{
                    server_id: "gate2",
                    network_id: "::",
                    ip: "192.168.0.2"
                  }
                ],
              remote:
                [
                  %{
                    password: "asdfasdf",
                    network_id: "::",
                    ip: "8.8.8.8"
                  }
                ]
            }
        }
    }
  end

  def join("account:" <> _, _message, socket) do
    {:ok, bootstrap(), socket}
  end

  def handle_in("bootstrap", _, socket) do
    {:reply, {:ok, bootstrap()}, socket}
  end

  def handle_in(_, _, socket) do
    {:noreply, socket}
  end

  defp notify(id, data) do
    EHelixWeb.Endpoint.broadcast("account:" <> id, "event", data)
  end
end
