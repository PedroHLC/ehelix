use Mix.Config

config :ehelix, EHelixWeb.Endpoint,
  server: true,
  url: [host: "localhost", port: 4000],
  pubsub: [name: EHelix.PubSub,
           adapter: Phoenix.PubSub.PG2],
  allowed_cors: ~r/http?.*localhost*/,
  https: [
    port: 4000,
    otp_app: :ehelix,
    keyfile: "priv/dev/ssl.key",
    certfile: "priv/dev/ssl.crt"
  ],
  secret_key_base: "asdfghjklzxcvbnm,./';[]-=1234567890!",
  debug_errors: true,
  code_reloader: true,
  check_origin: false

config :logger, :console, format: "[$level] $message\n"

config :phoenix, :stacktrace_depth, 20
