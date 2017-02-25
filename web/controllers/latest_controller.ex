defmodule NewsFeed.LatestController do
  use NewsFeed.Web, :controller

  alias NewsFeed.{Latest, Repo, NfStore, NfParser, NfRepo}
  require Logger


## TODO: return the trending posts according to views count order
  def index(conn, _params) do
    latest_posts = Repo.all(Latest)
    render(conn, "index.json", latests: latest_posts)
  end
  
end