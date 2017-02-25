defmodule NewsFeed.TopController do
  use NewsFeed.Web, :controller

  alias NewsFeed.{Top, NfRepo}
  require Logger

  def index(conn, _params) do
    top_posts =  NfRepo.top_posts
    render(conn, "index.json", tops: top_posts)
  end
end