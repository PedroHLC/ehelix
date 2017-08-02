defmodule EHelixWeb.Endpoint do
  use Phoenix.Endpoint, otp_app: :ehelix

  socket "/", EHelixWeb.UserSocket

  plug Corsica,
    origins: ~r/http?.*localhost*/,
    allow_headers: ["content-type", "x-request-id"],
    expose_headers: ["X-Request-Id"]

  plug Plug.RequestId
  plug Plug.Logger

  plug Plug.Parsers,
    length: 2_000_000,
    read_timeout: 5_000,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Poison

  plug EHelixWeb.Router

  def init(_key, config) do
    if config[:load_from_system_env] do
      port = System.get_env("PORT") || raise "expected the PORT environment variable to be set"
      {:ok, Keyword.put(config, :http, [:inet6, port: port])}
    else
      {:ok, config}
    end
  end
end
