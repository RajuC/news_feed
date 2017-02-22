defmodule NewsFeed.TrendingController do
  use NewsFeed.Web, :controller


## TODO :
  def create(conn, params) do
    # IO.inspect "========================== params"
    # IO.inspect params
    # Task.async(fn -> Module.function(arg) end)  // async fucntion
    send_resp(conn, 202, "inserted")
  end
end