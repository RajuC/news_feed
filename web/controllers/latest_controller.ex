defmodule NewsFeed.LatestController do
  use NewsFeed.Web, :controller

  alias NewsFeed.{Latest, NfRepo}
  require Logger


## TODO: return the trending posts according to views count order
  def index(conn, _params) do
    latest_posts =  NfRepo.latest_posts
    render(conn, "index.json", latests: latest_posts)
  end
  
end