defmodule NewsFeed.NfRepo do


  # import Ecto.Query, only: [from: 1, from: 2]
  import Ecto.Query
  alias NewsFeed.{Top, Latest, Trending, Source, Repo, TopView, LatestView, TrendingView}


  def get_post(post_id) do
    case get_top_post(post_id) do
      nil ->
        get_latest_post(post_id)
      post ->
        post  
    end 
  end

  def get_top_post(post_id) do
    Repo.get_by(Top, post_id: post_id)
  end

  def get_latest_post(post_id) do
    Repo.get_by(Latest, post_id: post_id)
  end

  def  get_sources(:country, country) do
    Source 
      |> where([u], u.country == ^country)
      |> select([u], u.source_id)
      |> Repo.all
  end

  def  get_sources(:source_types, lang) do
    Source 
      |> where([u], u.language == ^lang)
      |> select([u], %{source_id: u.source_id, source_types: u.source_types})
      |> Repo.all
  end

  def get_all_posts() do
    top_posts       = Task.async(fn() -> top_posts end)
    latest_posts    = Task.async(fn() -> latest_posts end)
    trending_posts  = Task.async(fn() -> trending_posts end)
    [top_posts, latest_posts, trending_posts] |> Enum.map(&await/1) |> List.flatten
  end

  def trending_posts() do
    Trending
      |> order_by([u], desc: u.views)
      |> select([u], u.post_id)
      |> Repo.all
      |> Enum.map(&Task.async(fn() -> get_post(&1) end))
      |> Enum.map(&await/1)
  end

  def top_posts() do
    Top
      |> order_by([u], desc: u.published_at)
      |> Repo.all
  end

  def latest_posts() do
    Latest
      |> order_by([u], desc: u.published_at)
      |> Repo.all
  end

# Task.async(fn() -> :entity |> CsharpRepo.get(author_id) end) |> &await/1

  def get_all_posts_by_source(source_id) do
    top_posts       = Task.async(fn() -> source_id |> top_posts_by_source end)
    latest_posts    = Task.async(fn() -> source_id |> latest_posts_by_source end)
    trending_posts  = Task.async(fn() -> source_id |> trending_posts_by_source end)
    [top_posts, latest_posts, trending_posts] |> Enum.map(&await/1) |> List.flatten
  end


### TODO : refactor the below code to one function

# Top |> order_by([u], desc: u.published_at) |> where([u], u.source_id == "the-hindu") |> Repo.all
#     posts |> Enum.map(&Task.async(fn() ->  end))
#             |> Enum.map(&await/1)  


  defp top_posts_by_source(source_id) do
    posts = source_id |> get_posts_by_source(Top)
    %{data: top_posts} = TopView.render("index.json", %{tops: posts}) 
    top_posts
  end

  defp latest_posts_by_source(source_id) do
    posts = source_id |> get_posts_by_source(Latest)
    %{data: latest_posts} = LatestView.render("index.json", %{latests: posts})
    latest_posts
  end

  defp trending_posts_by_source(source_id) do
    posts = 
      Trending
        |> order_by([u], desc: u.views)
        |> where([u], u.source_id == ^source_id)
        |> select([u], u.post_id)
        |> Repo.all
        |> Enum.map(&Task.async(fn() -> get_post(&1) end))
        |> Enum.map(&await/1)
      %{data: trending_posts} = TrendingView.render("index.json", %{trendings: posts})
      trending_posts
  end

  defp get_posts_by_source(source_id, model) do
      model
        |> order_by([u], desc: u.published_at)
        |> where([u], u.source_id == ^source_id)
        |> Repo.all
  end


  defp await(task) do
    Task.await(task)
  end

end