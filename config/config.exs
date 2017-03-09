# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :news_feed,
  ecto_repos: [NewsFeed.Repo]

# Configures the endpoint
config :news_feed, NewsFeed.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "wsXR2BpM7Nv5zJTliGsD20iykDkI0srFv+pq2jicrz+AyLn9v2Dd2PWi1L8aL9bz",
  render_errors: [view: NewsFeed.ErrorView, accepts: ~w(html json)],
  pubsub: [name: NewsFeed.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Configure phoenix generators
config :phoenix, :generators,
  binary_id: true,
  migration: false,
  sample_binary_id: "111111111111111111111111"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"


config :sparkpost, api_key: "sdfdgdfgdfgdf"

config :news_feed, :domain, "raju.dfgdf@dfgdfdfgdf.com"
