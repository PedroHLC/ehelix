defmodule EHelix.Emulator.Requests do
  def handle_request(:logout, state) do
    pid = state.account.notifier

    if pid do
      send(pid,  :shutdown)
    end

    {:disconnect, state}
  end

  def handle_request(_, state) do
    {%{}, state}
  end
end
