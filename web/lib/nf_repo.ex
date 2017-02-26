defmodule NewsFeed.NfRepo do


  # import Ecto.Query, only: [from: 1, from: 2]
  import Ecto.Query
  @count 30
  @source_id_count 15
  alias NewsFeed.{Top, Latest, Trending, Source, Repo, PostView}


  def get_post(post_id) do
    case get_top_post(post_id) do
      nil ->
        get_latest_post(post_id)
      post ->
        post  
    end 
  end

  def get_top_post(post_id) do
    Top |> Repo.get_by(post_id: post_id) 
  end

  def get_latest_post(post_id) do
    Latest |> Repo.get_by(post_id: post_id)
  end

  def get_trending_post(post_id) do
    post_id |> get_post |> Map.merge(%{post_type: "trending"})
  end

  def  get_sources(:language, lang) do
    Source 
      |> where([u], u.language == ^lang)
      |> select([u], %{source_id: u.source_id, source_types: u.source_types})
      |> Repo.all
  end

  def  get_sources(:country, country) do
    Source 
      |> where([u], u.country == ^country)
      |> select([u], u.source_id)
      |> Repo.all
  end

  def get_sources(:category, category) do
    Source 
      |> where([u], u.category == ^category)
      |> select([u], u.source_id)
      |> Repo.all
  end

  def get_all_posts() do
    top_posts       = Task.async(fn() -> top_posts() end)
    latest_posts    = Task.async(fn() -> latest_posts() end)
    trending_posts  = Task.async(fn() -> trending_posts() end)
    [top_posts, latest_posts, trending_posts] 
      |> Enum.map(&await/1) 
      |> List.flatten
      |> Enum.shuffle
  end

  def trending_posts() do
    Trending
      |> order_by([u], desc: u.views)
      |> select([u], u.post_id)
      |> Repo.all
      |> Enum.map(&Task.async(fn() -> get_trending_post(&1) end))
      |> Enum.map(&await/1)
      |> Enum.take(@count)
      |> Enum.shuffle
  end

  def top_posts() do
    Top
      |> order_by([u], desc: u.published_at)
      |> Repo.all
      |> Enum.take(@count)
      |> Enum.shuffle
  end

  def latest_posts() do
    Latest
      |> order_by([u], desc: u.published_at)
      |> Repo.all
      |> Enum.take(@count)
      |> Enum.shuffle
  end

# Task.async(fn() -> :entity |> CsharpRepo.get(author_id) end) |> &await/1

  def get_posts_by_source_id(source_id) do
    top_posts       = Task.async(fn() -> source_id |> top_posts_by_source_id end)
    latest_posts    = Task.async(fn() -> source_id |> latest_posts_by_source_id end)
    trending_posts  = Task.async(fn() -> source_id |> trending_posts_by_source_id end)
    [trending_posts, latest_posts, top_posts]
      |> Enum.map(&await/1)
      |> List.flatten
      |> Enum.shuffle
  end

  defp top_posts_by_source_id(source_id) do
    posts = source_id |> posts_by_source_id(Top)
    %{data: top_posts} = PostView.render("index.json", %{posts: posts}) 
    top_posts
  end

  defp latest_posts_by_source_id(source_id) do
    posts = source_id |> posts_by_source_id(Latest)
    %{data: latest_posts} = PostView.render("index.json", %{posts: posts})
    latest_posts
  end

  defp trending_posts_by_source_id(source_id) do
    posts = 
      Trending
        |> order_by([u], desc: u.views)
        |> where([u], u.source_id == ^source_id)
        |> select([u], u.post_id)
        |> Repo.all
        |> Enum.map(&Task.async(fn() -> get_trending_post(&1) end))
        |> Enum.map(&await/1)
    %{data: trending_posts} = PostView.render("index.json", %{posts: posts})
      trending_posts |> Enum.take(@source_id_count)
  end

  defp posts_by_source_id(source_id, model) do
      model
        |> order_by([u], desc: u.published_at)
        |> where([u], u.source_id == ^source_id)
        |> Repo.all
        |> Enum.take(@source_id_count)
  end


  defp await(task) do
    Task.await(task)
  end

end