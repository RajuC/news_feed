defmodule NewsFeed.NfRepo do


  # import Ecto.Query, only: [from: 1, from: 2]
  import Ecto.Query
  @all_count 10
  alias NewsFeed.{Post, Source, Repo, PostView, Subscriber}


  def get_subscribers() do
    Subscriber |> select([u], u.email)
               |> Repo.all
  end


  def get_post(post_id) do
    Post |> Repo.get_by(post_id: post_id)
  end

  # def get_top_post(post_id) do
  #   Post |> Repo.get_by(post_id: post_id) 
  # end

  # def get_latest_post(post_id) do
  #   Post |> Repo.get_by(post_id: post_id)
  # end

  # def get_trending_post(post_id) do
  #   post_id |> get_post |> Map.merge(%{post_type: "trending"})
  # end


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

  # def get_all_posts(offset) do
  #   posts_top       = Task.async(fn() -> top_posts() end)
  #   posts_latest    = Task.async(fn() -> latest_posts() end)
  #   posts_trending  = Task.async(fn() -> trending_posts() end)
  #   [posts_top, posts_latest, posts_trending]
  #     |> Enum.map(&await/1)
  #     |> Enum.map(fn(posts) -> posts |> posts_by_offset(offset) end) 
  #     |> List.flatten
  # end

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



# # Task.async(fn() -> :entity |> CsharpRepo.get(author_id) end) |> &await/1

#   def get_posts_by_source_id(source_id) do
#     posts_top       = Task.async(fn() -> source_id |> top_posts_by_source_id end)
#     posts_latest    = Task.async(fn() -> source_id |> latest_posts_by_source_id end)
#     posts_trending  = Task.async(fn() -> source_id |> trending_posts_by_source_id end)
#     [posts_trending, posts_latest, posts_top]
#       |> Enum.map(&await/1)
#       |> List.flatten
#   end


#### PRIVATE FUNCTIONS


  # defp top_posts_by_source_id(source_id) do
  #   posts = source_id |> posts_by_source_id(Post)
  #   %{data: posts_top} = PostView.render("index.json", %{posts: posts})
  #   posts_top
  # end

  # defp latest_posts_by_source_id(source_id) do
  #   posts = source_id |> posts_by_source_id(Post)
  #   %{data: posts_latest} = PostView.render("index.json", %{posts: posts})
  #   posts_latest
  # end

  # defp trending_posts_by_source_id(source_id) do
  #   posts = 
  #     Post
  #       |> order_by([u], desc: u.views)
  #       |> where([u], u.source_id == ^source_id)
  #       |> select([u], u.post_id)
  #       |> Repo.all
  #       |> Enum.map(&Task.async(fn() -> get_trending_post(&1) end))
  #       |> Enum.map(&await/1)
  #   %{data: posts_trending} = PostView.render("index.json", %{posts: posts})
  #     posts_trending
  # end




  # defp await(task) do
  #   Task.await(task)
  # end


  # defp posts_by_offset(posts, 0) do
  #   IO.inspect "========================== offset 0"
  #   IO.inspect 
  #  posts |> Enum.take(@all_count)
  # end 
  # defp posts_by_offset(posts, offset) do
  #   IO.inspect "========================== variable"
  #   IO.inspect 
  #   posts|> Enum.take(offset + @all_count) |> Enum.take(- @all_count)
  # end

end