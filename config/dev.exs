use Mix.Config

# For development, we disable any cache and enable
# debugging and code reloading.
#
# The watchers configuration can be used to run external
# watchers to your application. For example, we use it
# with brunch.io to recompile .js and .css sources.
config :news_feed, NewsFeed.Endpoint,
  http: [port: 4000],
  debug_errors: true,
  code_reloader: true,
  check_origin: false,
  watchers: [node: ["node_modules/brunch/bin/brunch", "watch", "--stdin",
                    cd: Path.expand("../", __DIR__)]]


# Watch static and templates for browser reloading.
config :news_feed, NewsFeed.Endpoint,
  live_reload: [
    patterns: [
      ~r{priv/static/.*(js|css|png|jpeg|jpg|gif|svg)$},
      ~r{priv/gettext/.*(po)$},
      ~r{web/views/.*(ex)$},
      ~r{web/templates/.*(eex)$}
    ]
  ]

# Do not include metadata nor timestamps in development logs
config :logger, :console, format: "[$level] $message\n"

# Set a higher stacktrace during development. Avoid configuring such
# in production as building large stacktraces may be expensive.
config :phoenix, :stacktrace_depth, 20

# Configure your database
config :news_feed, NewsFeed.Repo,
  adapter: Mongo.Ecto,
  database: "news_feed_dev",
  pool_size: 10


# ## env variables
# config :news_feed, :httpoison,     HTTPoison
# config :news_feed, :post_url,      'http://localhost:8080/post_file_content'
# config :news_feed, :access_token,  'access_token'
config :news_feed, :news_api_key,         "5ada76900905435791c07c1d9262e181"
config :news_feed, :news_api_url,         "https://newsapi.org/v1/articles"
config :news_feed, :news_source_api_url,  "https://newsapi.org/v1/sources"

## cron job for every fifteen minutes

# config :quantum, news_feed: [
#   crons: ["* * * * *": {"NewsFeed.AllNewsFeed", :fetch_news_feed}]
# ]

config :quantum, cron: [
  "*/5 * * * *": {"NewsFeed.AllNewsFeed", :fetch_news_feed},
  "@weekly":   {"NewsFeed.AllNewsFeed", :fetch_news_sources}
]

