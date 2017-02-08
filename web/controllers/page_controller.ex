defmodule NewsFeed.PageController do
  use NewsFeed.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
