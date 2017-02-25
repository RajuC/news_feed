defmodule NewsFeed.TopController do
  use NewsFeed.Web, :controller

  alias NewsFeed.{Top, Repo, NfStore, NfParser, NfRepo}
  require Logger


## TODO: return the trending posts according to views count order
  def index(conn, _params) do
    top_posts = Repo.all(Top)
    render(conn, "index.json", tops: top_posts)
  end

end