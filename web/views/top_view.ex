defmodule NewsFeed.TopView do
  use NewsFeed.Web, :view	

  def render("index.json", %{tops: top_posts}) do
    %{data: render_many(top_posts, NewsFeed.TopView, "top.json")}
  end
  def render("show.json", %{top: top_post}) do
    %{data: render_one(top_post, NewsFeed.TopView, "top.json")}
  end

  def render("top.json", %{top: top_post}) do
    %{post_id:          top_post.post_id,
      post_url:         top_post.post_url,
      url_to_image:     top_post.url_to_image,
      title:            top_post.title,
      source_id:        top_post.source_id,
      published_at:     top_post.published_at,
      description:      top_post.description,
      author:           top_post.author,
      post_type:        top_post.post_type
      }
  end
end
