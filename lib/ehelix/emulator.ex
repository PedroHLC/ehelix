defmodule EHelix.Emulator do
  use GenServer

  alias EHelix.Emulator.{Account, Server, Requests}

  # external api

  def start_link() do
    case GenServer.start_link(__MODULE__, [], []) do
      {:ok, pid} ->
        :ets.insert(:model_pid, {:pid, pid})

        {:ok, pid}
      error ->
        error
    end
  end

  def login do
    do_request(:login)
  end

  def sign_up do
    do_request(:sign_up)
  end

  def logged? do
    do_request(:logged?)
  end

  def account(info) do
    do_request({:account, info})
  end

  def requests(info) do
    do_request({:requests, info})
  end

  def server(info) do
    do_request({:server, info})
  end

  # genserver

  def init(_) do
    state =
      %{
        login: false,
        account: Account.initial_model,
        server: Server.initial_model
      }

    {:ok, state}
  end

  def handle_call(info, _, state) do
    {response, state} = handle_request(info, state)
    {:reply, response, state}
  end

  # requests

  def handle_request(:login, state) do
    {%{state | login: true}, state}
  end

  def handle_request(:sign_up, state) do
    {%{}, state}
  end

  def handle_request(:logged?, state) do
    %{login: login} = state
    {login, state}
  end

  def handle_request({channel, data}, state) do
    case channel do
      :account ->
        Account.handle_request(data, state)

      :server ->
        Server.handle_request(data, state)

      :requests ->
        Requests.handle_request(data, state)

      _ ->
        {%{code: :route_not_found}, state}
    end
  end

  def handle_request(_, state) do
    {%{ code: :channel_or_topic_not_found }, state}
  end

  # raw requester

  defp do_request(info) do
    [pid: pid] = :ets.lookup(:model_pid, :pid)
    GenServer.call(pid, info)
  end
end
