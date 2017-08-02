defmodule EHelix.Emulator.Requests do
  def handle_request(:logout, state) do
    {%{state | login: false}, state}
  end

  def handle_request(_, state) do
    {%{}, state}
  end
end
