defmodule EHelix.Emulator do
  use GenServer

  def start_link() do
    case GenServer.start_link(__MODULE__, [], []) do
      {:ok, pid} ->
        :ets.insert(:model_pid, {:pid, pid})

        {:ok, pid}
      error ->
        error
    end
  end

  def init(_) do
    {:ok, nil}
  end

  def set(data) do
    do_request({:set, data})
  end

  def get do
    do_request(:get)
  end

  def handle_call({:set, state}, _, _) do
    {:reply, state, state}
  end

  def handle_call(:get, _, state) do
    {:reply, state, state}
  end

  ###

  defp do_request(info) do
    [pid: pid] = :ets.lookup(:model_pid, :pid)
    GenServer.call(pid, info)
  end
end
