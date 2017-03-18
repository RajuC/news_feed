defmodule NewsFeed.Source do
  use NewsFeed.Web, :model
  alias NewsFeed.{NfParser}

  schema "sources" do
    field :source_id,       :string
    field :name,            :string      
    field :description,     :string
    field :url,             :string
    field :category,        :string
    field :language,        :string 
    field :country,         :string 
    field :urls_to_logos,   :map
    field :source_types,    {:array, :string}
    field :inserted_at,     :string, default: NfParser.now()
    field :updated_at,      :string, default: NfParser.now()
    # timestamps
  end


  @required_fields ~w(source_id name description category language url country urls_to_logos source_types)




  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @required_fields)
    |> unique_constraint(:source_id)
  end

end

