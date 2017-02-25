defmodule NewsFeed.TrendingController do
  use NewsFeed.Web, :controller

  alias NewsFeed.{Trending, Repo, NfStore, NfParser, NfRepo}
  require Logger


## TODO: return the trending posts according to views count order
  def index(conn, _params) do
    posts = NfRepo.trending_posts()
    render(conn, "index.json", trendings: posts)
  end

  def store_and_redirect(conn, %{"post_id" => post_id} = params) do
    post = post_id |> NfRepo.get_post
    case NfRepo.get_trending(post_id) do
      nil           ->
        updated_post = post
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
end
