defmodule NewsFeed.NfStore do

  alias NewsFeed.{Top, Latest, Source, Repo}
  require Logger

  def store_article(%{"article_type" => "top"} = article) do
    %Top{} |> Top.changeset(article) |> store_to_repo
  end
  def store_article(%{"article_type" => "latest"} = article) do
    %Latest{} |> Latest.changeset(article) |> store_to_repo
  end



  def store_source(source) do
    %Source{} |> Source.changeset(source) |> store_to_repo
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