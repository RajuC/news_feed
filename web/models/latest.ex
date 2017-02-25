defmodule NewsFeed.Latest do
  use NewsFeed.Web, :model
  alias NewsFeed.{NfParser}

  schema "latest_articles" do  
    field :author,        :string
    field :post_id,       :string
    field :description,   :string 
    field :published_at,  :string
    field :title,         :string
    field :post_url,      :string
    field :original_url,  :string
    field :url_to_image,  :string
    field :source_id,     :string
    field :post_type,     :string
    field :inserted_at,   :string, default: NfParser.now()
    field :updated_at,    :string, default: NfParser.now()
    # timestamps
  end


  @required_fields ~w(post_id author description published_at title original_url post_url url_to_image source_id post_type)
  @optional_fields ~w()



  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @required_fields, @optional_fields)
    |> unique_constraint(:title)
    |> unique_constraint(:post_id)
  end

end