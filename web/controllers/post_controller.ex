defmodule NewsFeed.PostController do
  use NewsFeed.Web, :controller

  alias NewsFeed.{Post, Repo, NfStore, NfParser, NfRepo}

  @count 20


  def show(conn, %{"post_id" => post_id} = params) do
    post = post_id |> NfRepo.get_post()
    conn |> render("post.json", post: post)
  end

  def all_news(conn, params) do
    posts = NfRepo.all_posts()
    conn |> render_post(posts, params)
  end

  def top_news(conn, params) do
    posts =  :post_type |> NfRepo.get_posts("top")
    conn |> render_post(posts, params)
  end

  def latest_news(conn, params) do  
    posts =  :post_type |> NfRepo.get_posts("latest")
    conn |> render_post(posts, params)
  end

  def trending_news(conn, params) do
    posts =  :trending |> NfRepo.get_posts("trending")
    conn |> render_post(posts, params)
  end

  def country_news(conn, %{"country" => country} = params ) do
  	:country 
      |> NfRepo.get_sources(country)
      |> posts_by_source_id(conn, params)
  end

  def category_news(conn, %{"type" => category} = params) do
    :category 
      |> NfRepo.get_sources(category)
      |> posts_by_source_id(conn, params)
  end   

  def update_post(conn, %{"post_id" => post_id} = params) do
    post = Post |> Repo.get_by(post_id: post_id)
    framed_post = post |> NfParser.frame_trending_post(params)
    post |> Post.changeset(framed_post) |> NfStore.update_to_repo
    IO.inspect "post_url and redirecting to external url"
    IO.inspect post.post_url
    orig_url = post.original_url 
                |> String.replace("\n", "")
                |> String.replace("\t", "")
                |> String.replace(" ",  "")
    redirect(conn, external: orig_url)
  end



## PRIVATE Fucntions

  defp posts_by_source_id(source_ids, conn, params) do
    posts = 
      source_ids
        |> Enum.map(&Task.async(fn() -> NfRepo.get_posts_by_source_id(&1) end))
        |> Enum.map(&await/1)
        |> List.flatten
    conn |> render_post(posts, params)
  end

  defp await(task) do
    Task.await(task)
  end
  
  defp posts_by_offset(posts, 20) do
   posts |> Enum.take(@count)
  end 
  defp posts_by_offset(posts, offset) do
    posts|> Enum.take(offset + @count) |> Enum.take(- @count)
  end

  defp render_post(conn, posts, params) do
  offset = params |> get_offset()
  posts  = posts |> posts_by_offset(offset)
  render(conn, "index.json", posts: posts,
                             offset: offset,
                             limit: @count,
                             page:  div(offset, @count))
  end

  defp get_offset(%{"offset" => "0"}), do: 20
  defp get_offset(%{"offset" => offset, "posts" => "prev"}) do
    (offset |> String.to_integer()) - @count 
  end
  defp get_offset(%{"offset" => offset, "posts" => "next"}) do
    (offset |> String.to_integer()) + @count 
  end
  defp get_offset(%{}), do: 20

end