defmodule NewsFeed.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
  	create table(:posts, primary_key: false) do
      add :id,            :uuid,   primary_key: true
      add :post_id,       :string
      add :author,        :string
      add :description,   :string
      add :published_at,  :string
      add :title,         :string
      add :post_url,      :string
      add :original_url,  :string
      add :url_to_image,  :string
      add :post_type,     :string
      add :source_id,     :string
      add :views,         :integer
      add :likes,         :integer
      add :dislikes,      :integer
      add :inserted_at,   :string
      add :updated_at,    :string

      # timestamps
    end
    create unique_index(:posts, [:post_id], unique: true)
    create unique_index(:posts, [:title],   unique: true)
  end
end

