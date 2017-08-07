defmodule EHelix.Emulator.Account do
  def initial_model do
    %{
      email: "renato@hackerexperience.com",
      piture: "https://avatars1.githubusercontent.com/u/5695464?v=4&s=460",
      bounces: nil,
      database: nil,
      inventory: nil,
      servers: ["gate1", "gate2", "gate3"],
      activeGateway: "gate2"
    }
  end

  # bootstrap is expected to return:
  #
  #    { account :
  #      { email : String
  #      , picture : String
  #      , bounces : Pending
  #      , database : Pending
  #      , inventory : Pending
  #      , servers : List String
  #      , activeGateway : String
  #      }
  #    , meta :
  #      { online : Int
  #      }
  #    , servers :
  #      List
  #        { filesystem : Pending
  #        , hardware : Pending
  #        , processes : Pending
  #        , tunnels : Pending
  #        , logs :
  #          List
  #            { insertedAt : Time -- unix epoch
  #            , logID: String
  #            , msg : String
  #            }
  #        }
  #    }
  def handle_request(:bootstrap, state) do
    response =
      %{
        account:
          state.account,
        meta:
          %{ online: 1 },
        servers:
          state.server.gateways
      }
    {response, state}
  end

  def handle_request(_, state) do
    {{:error, :notfound}, state}
  end

  defp get(state) do
    state.account
  end

  defp set(state, account) do
    %{state | account: account}
  end
end
