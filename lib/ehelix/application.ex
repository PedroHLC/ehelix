defmodule EHelix.Application do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec

    :ets.new(:model_pid, [:set, :public, :named_table])

    children = [
      supervisor(EHelix.Emulator, []),
      supervisor(EHelixWeb.Endpoint, []),
    ]

    opts = [strategy: :one_for_one, name: EHelix.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def config_change(changed, _new, removed) do
    EHelixWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
