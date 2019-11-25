# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :bloggy,
  ecto_repos: [Bloggy.Repo]

# Configures the endpoint
config :bloggy, BloggyWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "TPnMUO18tUXFKFvRbhz2aIH8663Rk3gAtTdKzNEI7nDY3XHB49fdH9OpQJVVA5XQ",
  render_errors: [view: BloggyWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Bloggy.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
