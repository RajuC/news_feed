use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :news_feed, NewsFeed.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :news_feed, NewsFeed.Repo,
  adapter: Mongo.Ecto,
  database: "news_feed_test",
  pool_size: 1
