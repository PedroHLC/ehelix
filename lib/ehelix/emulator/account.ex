defmodule EHelix.Emulator.Account do
  def initial_model do
    %{notifier: nil}
  end

  def handle_request({:set_notifier, pid}, state) do
    account = get(state)
    account = %{account | notifier: pid}
    state = set(state, account)

    {%{}, state}
  end

  def handle_request(_, state) do
    {%{}, state}
  end

  defp get(state) do
    state.account
  end

  defp set(state, account) do
    %{state | account: account}
  end
end
