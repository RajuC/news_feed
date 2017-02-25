defmodule NewsFeed.LatestView do
  use NewsFeed.Web, :view	

  def render("index.json", %{latests: latest_posts}) do
    %{data: render_many(latest_posts, NewsFeed.LatestView, "latest.json")}
  end
  def render("show.json", %{latest: latest_post}) do
    %{data: render_one(latest_post, NewsFeed.LatestView, "latest.json")}
  end

  def render("latest.json", %{latest: latest_post}) do
    %{post_id:          latest_post.post_id,
      post_url:         latest_post.post_url,
      url_to_image:     latest_post.url_to_image,
      title:            latest_post.title,
      source_id:        latest_post.source_id,
      published_at:     latest_post.published_at,
      description:      latest_post.description,
      author:           latest_post.author,
      post_type:        latest_post.post_type
      }
  end
end
