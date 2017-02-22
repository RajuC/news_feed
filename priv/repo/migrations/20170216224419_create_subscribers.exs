defmodule NewsFeed.Repo.Migrations.CreateSubscribers do
  use Ecto.Migration

  def change do
  	create table(:subscribers, primary_key: false) do
      add :id,            	:uuid,    primary_key: true    
      add :email,     	    :string
      add :is_verified,     :string
      add :inserted_at,   	:string
      add :updated_at,    	:string
    end
    create unique_index(:subscribers, [:email], unique: true)
  end
end

