defmodule NewsFeed.Top do
  use NewsFeed.Web, :model

  schema "top_articles" do
    field :author,        :string
    field :description,   :string 
    field :published_at,  :string
    field :title,         :string   
    field :url,           :string
    field :url_to_image,  :string
    field :source,        :string
    # field :created_at,    :datetime, default: Ecto.DateTime.local
    # field :updated_at,    :datetime, default: Ecto.DateTime.local
    timestamps()
  end


  @required_fields ~w(author description published_at title url url_to_image source)
  @optional_fields ~w()



  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @required_fields, @optional_fields)
    |> unique_constraint(:title)
  end
end