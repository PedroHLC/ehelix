defmodule EHelixWeb.ServerChannel do
  use EHelixWeb, :channel


  def join("server:" <> _, _message, socket) do
    {:ok, socket}
  end

  def handle_in("file.index", _, socket) do
    reply =
      %{
        data:
          [
            %{
              id: "001",
              name: "home",
              children:
                [
                  %{
                    id: "002",
                    name: "root",
                    children:
                      [
                        %{
                          id: "003",
                          name: "Firewall",
                          extension: "fwl",
                          size: "900000",
                          version: "2",
                          modules: [
                            %{ name: "Active", version: "1" },
                            %{ name: "Passive", version: "2" }
                          ]
                        },
                        %{
                          id: "004",
                          name: "Virus",
                          extension: "spam",
                          size: "752000",
                          version: "2",
                          modules: [
                            %{ name: "Active", version: "1" }
                          ]
                        }
                      ]
                  }
                ]
            }
          ]
      }

    {{:ok, reply}, socket}
  end

  defp notify(id, data) do
    EHelixWeb.Endpoint.broadcast("server:" <> id, "event", data)
  end
end
