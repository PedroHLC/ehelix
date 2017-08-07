defmodule EHelix.Emulator.Server do
  def initial_model do
    %{
      gateways: [],
      endpoints: []
    }
  end

  def handle_request(_, state) do
    {{:error, :notfound}, state}
  end
end
