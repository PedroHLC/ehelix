defmodule EHelix.Emulator.Requests do
  def handle_request(:logout, state) do
    {:disconnect, state}
  end

  def handle_request(_, state) do
    {%{}, state}
  end
end
