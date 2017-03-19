defmodule NewsFeed.NfRepo do


  # import Ecto.Query, only: [from: 1, from: 2]
  import Ecto.Query
  alias NewsFeed.{Post, Source, Repo, Subscriber}


  def get_subscribers() do
    Subscriber |> select([u], u.email)
               |> Repo.all
  end

  def get_post(post_id) do
    Post |> Repo.get_by(post_id: post_id)
  end

  # Get the Post Sources
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

  def  get_posts_by_source_id(source_id) do
    :source_id |> get_posts(source_id)
  end  

  # To get all the posts
  def all_posts() do
    Post |> order_by([u], desc: u.published_at)
         |> Repo.all
  end

  # To get Top, Latest, Trending, Country and Category News
  def get_posts(:post_type, post_type) do
    Post |> where([u], u.post_type == ^post_type)
         |> order_by([u], desc: u.published_at)
         |> Repo.all
  end
  def get_posts(:source_id, source_id) do
    Post |> order_by([u], desc: u.published_at)
         |> where([u], u.source_id == ^source_id)
         |> Repo.all
  end
  def get_posts(:trending, _) do
    Post |> order_by([u], desc: u.views)
         |> Repo.all
  end

end