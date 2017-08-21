use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :janji_api, JanjiApiWeb.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :janji_api, JanjiApi.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "janji_api_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# Configure Comeonin for test env
config :comeonin, :bcrypt_log_rounds, 4
config :comeonin, :pbkdf2_rounds, 1

# import the config/test.local.exs
# which is a specific local config for test environment
# and should be versioned separately.
import_config "test.local.exs"
