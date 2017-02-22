defmodule NewsFeed.Contact do
  use NewsFeed.Web, :model
  alias NewsFeed.{NfParser}

  schema "subscribers" do  
    field :email,       :string
    field :name,        :string
    field :message,     :string
    field :title,       :string
    field :have_replied,:string, default: "no"
    field :inserted_at, :string, default: NfParser.now()
    field :updated_at,  :string, default: NfParser.now()
  end


  @required_fields ~w(email name message title have_replied)
  @optional_fields ~w()



  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @required_fields, @optional_fields)
  end

end