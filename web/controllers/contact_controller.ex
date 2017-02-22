defmodule NewsFeed.ContactController do
  use NewsFeed.Web, :controller

  alias NewsFeed.{Contact, Repo}
  require Logger

  def index(conn, _params) do
    contacts = Repo.all(Contact)
    render(conn, "index.json", contacts: contacts)
  end

  def create(conn, params) do
    changeset    = Contact.changeset(%Contact{}, params)
    case Repo.insert(changeset) do
      {:ok, contact} ->
        Logger.info "#{__MODULE__}||Inserted||contact message: #{inspect contact}"
        conn
          |> send_resp(201, "success")
      {:error, changeset} ->
        Logger.info "#{__MODULE__}||Error||contact changeset: #{inspect changeset}"
        conn
          |> send_resp(422, "error")
    end
  end
end
