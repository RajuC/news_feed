defmodule NewsFeed.Router do
  use NewsFeed.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", NewsFeed do
    pipe_through :api # Use the default browser stack
    post    "/subscribe",       SubscriberController,  :create
    post    "/contact",         ContactController,     :create
    post    "/trending",        TrendingController,    :create
    get     "/trending",        TrendingController,    :index
    get     "/trending/:type",  TrendingController,    :show
    get     "/",                PageController,        :index
  end





  # Other scopes may use custom stacks.
  # scope "/api", NewsFeed do
  #   pipe_through :api
  # end
end


## todos
#### cron job to send subscriptions to email ids
#### verify the subscriber