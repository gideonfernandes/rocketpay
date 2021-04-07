# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :rocketmeals,
  ecto_repos: [Rocketmeals.Repo]

config :rocketmeals, Rocketmeals.Repo,
  migration_primary_key: [type: :binary_id],
  migration_foreign_key: [type: :binary_id]

# Configures the endpoint
config :rocketmeals, RocketmealsWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "PKfFuDskUzDjAz2xmUY60G5oHNN5ByzI9CFOjDhBnLtU+EMXgnlhIU351uyhD+kx",
  render_errors: [view: RocketmealsWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: Rocketmeals.PubSub,
  live_view: [signing_salt: "/6LU9egX"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
