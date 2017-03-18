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
    get    "/unsubscribe",              SubscriberController,  :unsubscribe
    post    "/contact",                 ContactController,     :create  
    get     "/trending/:post_id",       PostController,        :update_post
    get     "/posts",                   PostController,        :all_news
    get     "/posts/top",               PostController,        :top_news
    get     "/posts/latest",            PostController,        :latest_news
    get     "/posts/trending",          PostController,        :trending_news       
    get     "/posts/country/:country",  PostController,        :country_news
    get     "/posts/category/:type",    PostController,        :category_news  
    get     "/",                        PageController,        :index
  end





  # Other scopes may use custom stacks.
  # scope "/api", NewsFeed do
  #   pipe_through :api
  # end
end

