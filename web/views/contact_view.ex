defmodule NewsFeed.ContactView do
  use NewsFeed.Web, :view	

  def render("index.json", %{contacts: contacts}) do
    %{data: render_many(contacts, NewsFeed.ContactView, "contact.json")}
  end
  def render("show.json", %{contact: contact}) do
    %{data: render_one(contact, NewsFeed.ContactView, "contact.json")}
  end

  def render("contact.json", %{contact: contact}) do
    %{id:           contact.id,
      email:        contact.email,
      message:      contact.message,
      have_replied: contact.have_replied}
  end
end
