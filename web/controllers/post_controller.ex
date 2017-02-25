defmodule NewsFeed.PostController do
	use NewsFeed.Web, :controller


  alias NewsFeed.{Trending, Repo, NfStore, NfParser, NfRepo}

  def all_news(conn, _params) do
    posts = NfRepo.get_all_posts
    render(conn, "index.json", posts: posts) 
  end

  def top_news(conn, _params) do
    posts = NfRepo.top_posts
    render(conn, "index.json", posts: posts) 
  end

  def latest_news(conn, _params) do
    posts = NfRepo.latest_posts
    render(conn, "index.json", posts: posts) 
  end

  def trending_news(conn, _params) do
    posts = NfRepo.trending_posts
    render(conn, "index.json", posts: posts) 
  end

  def country_news(conn, %{"country" => country}) do
  	:country 
      |> NfRepo.get_sources(country)
      |> posts_by_source_id(conn)
  end

  def category_news(conn, %{"type" => category}) do
    :category 
      |> NfRepo.get_sources(category)
      |> posts_by_source_id(conn)
  end   

  def create_trending(conn, %{"post_id" => post_id} = params) do
    post = Trending |> Repo.get_by(post_id: post_id)
    case post do
      nil           ->
        updated_post = post_id
                        |> NfRepo.get_trending_post
                        |> Map.merge(%{views: 0})
                        |> NfParser.frame_trending_post(params)
        %Trending{} |> Trending.changeset(updated_post) |> NfStore.store_to_repo
      trending_post ->
        updated_post = trending_post
                        |> NfParser.frame_trending_post(params)
        trending_post |> Trending.changeset(updated_post) |> NfStore.update_to_repo
    end
    redirect(conn, external: post.original_url)
  end



## PRIVATE Fucntions

  defp posts_by_source_id(source_ids, conn) do
    posts = 
      source_ids
        |> Enum.map(&Task.async(fn() -> NfRepo.get_posts_by_source_id(&1) end))
        |> Enum.map(&await/1)
        |> List.flatten
    render(conn, "index.json", posts: posts) 
  end


  defp await(task) do
    Task.await(task)
  end

end