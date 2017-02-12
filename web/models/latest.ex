defmodule NewsFeed.Latest do
  use NewsFeed.Web, :model
  alias NewsFeed.{NfParser}

  schema "latest_articles" do  
    field :author,        :string
    field :description,   :string 
    field :published_at,  :string
    field :title,         :string   
    field :url,           :string
    field :url_to_image,  :string
    field :source,        :string
    field :article_type,  :string
    field :inserted_at,   :string, default: NfParser.now()
    field :updated_at,    :string, default: NfParser.now()
    # timestamps
  end


  @required_fields ~w(author description published_at title url url_to_image source article_type)
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