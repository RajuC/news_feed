defmodule NewsFeed.NfStore do

  alias NewsFeed.{Top, Latest, Source, Repo}
  require Logger

  def store_article(%{"article_type" => "top"} = article) do
    case Repo.get_by(Top, title: article["title"]) do
      nil       ->
        %Top{} |> Top.changeset(article) |> store_to_repo
      article_found  ->
        Logger.info "#{__MODULE__}||Document exists||article: #{inspect article_found}"
        {:ok, :already_exists}
    end
  end
  def store_article(%{"article_type" => "latest"} = article) do
        case Repo.get_by(Latest, title: article["title"]) do
      nil       ->
        %Latest{} |> Latest.changeset(article) |> store_to_repo 
      article_found  ->
        Logger.info "#{__MODULE__}||Document exists||article: #{inspect article_found}"
        {:ok, :already_exists}
    end
  end



  def store_source(source) do
    case Repo.get_by(Source, source_id: source["source_id"]) do
      nil       ->
        %Source{} |> Source.changeset(source) |> store_to_repo
      source_found  ->
        Logger.info "#{__MODULE__}||Document exists||article: #{inspect source_found}"
        {:ok, :already_exists}
    end
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

end