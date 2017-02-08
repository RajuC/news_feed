defmodule NewsFeed.Repo.Migrations.CreateTopArticles do
  use Ecto.Migration

  def change do
  	create table(:top_articles, primary_key: false) do
      add :author,        :string
      add :description,   :string
      add :published_at,  :string
      add :title,         :string
      add :url,           :string
      add :url_to_image,  :string
      add :source,        :string

      timestamps()
    end

  end
end

