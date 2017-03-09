defmodule NewsFeed.NfSubscriptions do

  alias SparkPost.{Content, Transmission}
  @from   Application.get_env(:news_feed, :domain)
  def send_message(recipients_list, post) do
    # IO.inspect "========================== recipients_list"
    # IO.inspect recipients_list
      Transmission.send(%Transmission{
          recipients: recipients_list,
          content: %Content.Inline{
            subject:  frame_subject(post.title),
            from:     @from, 
            text:     post.description,
            html:     frame_html(post)
          }
      })
  end

  def frame_subject(title) do
    "Trending News||" <> title |> String.slice(0..40)
  end

  def frame_html(post) do
  "<h2><a href='www.a2znewstoday.com/posts/trending'>#{post.title}</a></h2><center><a href='www.a2znewstoday.com/posts/trending'><img src='#{post.url_to_image}' alt='Mountain View' style='width:304px;height:228px;'></a></center><h3>#{post.description}</h3><h3>you can read more news at <a href='www.a2znewstoday.com'>a2znewstoday.com</a></h3>"
  end
end