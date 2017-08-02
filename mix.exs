defmodule EHelix.Mixfile do
  use Mix.Project

  def project do
    [
      app: :ehelix,
      version: "0.0.1",
      elixir: "~> 1.4",
      elixirc_paths: ["lib"],
      compilers: [:phoenix] ++ Mix.compilers,
      start_permanent: Mix.env == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      mod: {EHelix.Application, []},
      extra_applications: [:logger, :runtime_tools, :corsica, :remix]
    ]
  end

  defp deps do
    [
      {:phoenix, "~> 1.3.0"},
      {:phoenix_pubsub, "~> 1.0"},
      {:cowboy, "~> 1.0"},
      {:corsica, "~> 1.0"},
      {:remix, "~> 0.0.1"}
    ]
  end
end
