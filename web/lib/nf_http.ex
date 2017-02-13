defmodule NewsFeed.NfHttp do

  @news_api_key         Application.get_env(:news_feed, :news_api_key)
  @news_api_url         Application.get_env(:news_feed, :news_api_url)
  @news_source_api_url  Application.get_env(:news_feed, :news_source_api_url)

  require Logger

#https://newsapi.org/v1/articles?source=cnn&sortBy=top&apiKey=5ada76900905435791c07c1d9262e181



  def http_articles(source, sort_by) do
    source |> articles_query(sort_by) |> get_http
  end

  def http_sources() do
    sources_query() |> get_http
  end

  def get_http(query) do
    Logger.info "#{__MODULE__}|| query: #{query}"
    HTTPoison.get!(query).body |> Poison.decode!
  end




  ### private functions
  defp articles_query(source, sort_by) do
    @news_api_url <> "?" <> "source=" <> source <> "&sortBy=" <> sort_by <> "&apiKey=" <> @news_api_key
  end

  defp sources_query() do
    @news_source_api_url <> "?" <> "&apiKey=" <> @news_api_key
  end

end


