defmodule NewsFeed.PostController do
	use NewsFeed.Web, :controller

  alias NewsFeed.{PostView, NfRepo}

  def get_country_news(conn, %{"country" => country} = params) do
    posts = 
    	:country 
        |> NfRepo.get_sources(country)
        |> Enum.map(fn(source_id) -> 
            NfRepo.get_all_posts_by_source(source_id) end)
        |> List.flatten
    render(conn, "index.json", posts: posts) 
  end

  def all_posts(conn, _params) do
    posts = NfRepo.get_all_posts
    render(conn, "index.json", posts: posts) 
  end

end