defmodule NewsFeed.TrendingView do
  use NewsFeed.Web, :view	

  def render("index.json", %{trendings: trending_posts}) do
    %{data: render_many(trending_posts, NewsFeed.TrendingView, "trending.json")}
  end
  def render("show.json", %{trending: trending_post}) do
    %{data: render_one(trending_post, NewsFeed.TrendingView, "trending.json")}
  end

  def render("trending.json", %{trending: trending_post}) do
    %{post_id:          trending_post.post_id,
      post_url:         trending_post.post_url,
      url_to_image:     trending_post.url_to_image,
      title:            trending_post.title,
      source_id:        trending_post.source_id,
      published_at:     trending_post.published_at,
      description:      trending_post.description,
      author:           trending_post.author,
      post_type:        "trending"
      }
  end
end
