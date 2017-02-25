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
    post    "/subscribe",               SubscriberController,  :create
    post    "/contact",                 ContactController,     :create
    get     "/trending",                TrendingController,    :index   
    get     "/trending/:post_id",       TrendingController,    :store_and_redirect   ## trending posts
    get     "/posts",                   PostController,        :all_posts
    get     "/posts/top",               TopController,         :index
    get     "/posts/latest",            LatestController,      :index
    get     "/posts/country/:country",  PostController,        :get_country_news
    get     "/category/:news_type",     CategoryNewsController,:get_category_news  
    get     "/",                        PageController,        :index
  end





  # Other scopes may use custom stacks.
  # scope "/api", NewsFeed do
  #   pipe_through :api
  # end
end


## todos
#### cron job to send subscriptions to email ids
#### verify the subscriber