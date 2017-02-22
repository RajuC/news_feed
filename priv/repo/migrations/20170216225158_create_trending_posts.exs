defmodule NewsFeed.Repo.Migrations.CreateTrendingPosts do
  use Ecto.Migration

  def change do
  	create table(:trending_articles, primary_key: false) do
      add :id,            	:uuid,    primary_key: true    
      add :post_id,     	  :string
      add :article_type,    :string
      add :views,           :integer
      add :source_id,   	  :string
      add :inserted_at,     :string
      add :updated_at,    	:string
    end
    create unique_index(:trending_articles, [:post_id], unique: true)
  end
end
