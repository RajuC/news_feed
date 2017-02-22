defmodule NewsFeed.SubscriberController do
  use NewsFeed.Web, :controller


  alias NewsFeed.{Subscriber, Repo}
  require Logger

  def index(conn, _params) do
    subscribers = Repo.all(Subscriber)
    render(conn, "index.json", subscribers: subscribers)
  end

  def create(conn, params) do
    changeset    = Subscriber.changeset(%Subscriber{}, params)
    case Repo.insert(changeset) do
      {:ok, subscriber} ->
        Logger.info "#{__MODULE__}||Inserted||subscriber: #{inspect subscriber}"
        conn
          |> put_status(201)
          |> render("show.json", subscriber: subscriber)
      {:error, changeset} ->
        Logger.info "#{__MODULE__}||Error||subscriber changeset: #{inspect changeset}"
        conn
          |> send_resp(422, "subscriber already exists")
    end
  end
end
