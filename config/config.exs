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
  render_errors: [view: JanjiApiWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: JanjiApi.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
