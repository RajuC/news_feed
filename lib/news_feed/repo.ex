defmodule NewsFeed.Repo do
  use Ecto.Repo, otp_app: :news_feed, adapter: Mongo.Ecto
end
