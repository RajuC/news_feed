
defmodule NewsFeed.PostView do
  use NewsFeed.Web, :view	

  def render("index.json", %{posts: posts}) do
    %{data: render_many(posts, NewsFeed.PostView, "post.json")}
  end
  def render("show.json", %{post: post}) do
    %{data: render_one(post, NewsFeed.PostView, "post.json")}
  end

  def render("post.json", %{post: post}) do
    %{post_id:          post.post_id,
      post_url:         post.post_url,
      url_to_image:     post.url_to_image,
      title:            post.title,
      source_id:        post.source_id,
      published_at:     post.published_at,
      description:      post.description,
      author:           post.author,
      post_type:        post.post_type
      }
  end
end
