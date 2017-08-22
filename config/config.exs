# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :janji_api,
  ecto_repos: [JanjiApi.Repo]

# Configures the endpoint
config :janji_api, JanjiApiWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "LvcnmFh6Oe6hCeQM4JiZgVukEXJNeEj/ADt9Ma8UmATHxdkq3sDE2oND2Cm6ewW/",
  render_errors: [view: JanjiApiWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: JanjiApi.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Configures Guardian
config :guardian, Guardian,
  allowed_algos: ["HS512"], # optional
  verify_module: Guardian.JWT,  # optional
  issuer: "JanjiApiWeb",
  ttl: { 1, :days },
  allowed_drift: 2000,
  verify_issuer: true, # optional
  secret_key: "uTtbnwmq+Pf7VCKceMs/6pRJFnhg3ijV6FLO0228TIXjX6cfH1mcn2TieHTcWPVa",
  serializer: JanjiApiWeb.GuardianSerializer

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
