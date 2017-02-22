defmodule NewsFeed.Repo.Migrations.CreateLatestArticles do
  use Ecto.Migration

  def change do
  	create table(:latest_articles, primary_key: false) do
      add :id,            :uuid,    primary_key: true
      add :post_id,       :string
      add :author,        :string
      add :description,   :string
      add :published_at,  :string
      add :title,         :string
      add :url,           :string
      add :url_to_image,  :string
      add :article_type,  :string         
      add :source_id,     :string
      add :inserted_at,   :string
      add :updated_at,    :string

      # timestamps
    end
    create unique_index(:latest_articles, [:post_id], unique: true)
    create unique_index(:latest_articles, [:title],   unique: true)
  end
end
