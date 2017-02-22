defmodule NewsFeed.Repo.Migrations.CreateSource do
  use Ecto.Migration

  def change do
  	create table(:sources, primary_key: false) do
      add :id,            	:uuid,    primary_key: true
      add :source_id,     	:string
      add :name,          	:string
      add :description,   	:string
      add :url,           	:string
      add :category,      	:string
      add :language,      	:string
      add :country,       	:string
      add :urls_to_logos, 	:map
      add :source_types,    {:array, :string}
      add :inserted_at,   	:string
      add :updated_at,    	:string

      # timestamps
    end
    create unique_index(:sources, [:source_id], unique: true)
  end

end
