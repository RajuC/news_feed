defmodule NewsFeed.NfStore do

  alias NewsFeed.{Post, Source, Repo}
  require Logger

  def store_post(post) do
    %Post{} |> Post.changeset(post) |> store_to_repo()
  end

  def store_source(source) do
    %Source{} |> Source.changeset(source) |> store_to_repo()
  end


  def store_to_repo(changeset) do
    case Repo.insert(changeset) do
      {:ok, document} ->
        Logger.info "#{__MODULE__}|| New Document inserted||document: #{inspect document}"
        {:ok, :inserted}
      {:error, changeset} ->
        Logger.info "#{__MODULE__}||Insertion error||changeset: #{inspect changeset}"
        {:error, changeset}
    end
  end

  def update_to_repo(changeset) do
    case Repo.update(changeset) do
      {:ok, document} ->
        Logger.info "#{__MODULE__}||Document updated||document: #{inspect document}"
        {:ok, :updated}
      {:error, changeset} ->
        Logger.info "#{__MODULE__}||update error||changeset: #{inspect changeset}"
        {:error, changeset}
    end
  end
end