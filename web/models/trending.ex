defmodule NewsFeed.Trending do
  use NewsFeed.Web, :model
  alias NewsFeed.{NfParser}

  schema "trending_articles" do  
    field :post_id,       :string
    field :post_type,     :string
    field :source_id,     :string
    field :views,         :integer, default: 0
    field :inserted_at,   :string,  default: NfParser.now()
    field :updated_at,    :string,  default: NfParser.now()
  end


  @required_fields ~w(post_id post_type source_id views)
  @optional_fields ~w()



  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @required_fields, @optional_fields)
    |> unique_constraint(:post_id)
  end

end