defmodule NewsFeed.Subscriber do
  use NewsFeed.Web, :model
  alias NewsFeed.{NfParser}

  schema "subscribers" do  
    field :email,         :string
    field :is_verified,   :string
    field :subscriptions, {:array, :string}, default: ["trending"]
    field :inserted_at,   :string, default: NfParser.now()
    field :updated_at,    :string, default: NfParser.now()
  end


  @required_fields ~w(email subscriptions is_verified)
  @optional_fields ~w()



  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @required_fields, @optional_fields)
    |> unique_constraint(:email)
  end

end