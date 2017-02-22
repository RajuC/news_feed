defmodule NewsFeed.SubscriberView do
  use NewsFeed.Web, :view	

  def render("index.json", %{subscribers: subscribers}) do
    %{data: render_many(subscribers, NewsFeed.SubscriberView, "subscriber.json")}
  end
  def render("show.json", %{subscriber: subscriber}) do
    %{data: render_one(subscriber, NewsFeed.SubscriberView, "subscriber.json")}
  end

  def render("subscriber.json", %{subscriber: subscriber}) do
    %{id:      subscriber.id,
      email:   subscriber.email}
  end
end