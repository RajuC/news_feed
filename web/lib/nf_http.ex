defmodule NewsFeed.NfHttp do
	
  @news_api_key Application.get_env(:news_feed, :news_api_key)
  @news_api_url Application.get_env(:news_feed, :news_api_url)

  require Logger

#https://newsapi.org/v1/articles?source=cnn&sortBy=top&apiKey=5ada76900905435791c07c1d9262e181

# %{"articles" => [], "sortBy" => "top", "source" => "cnn", "status" => "ok"}

  def get_http(source, sort_by) do
    query = source |> create_query(sort_by)
    Logger.info "#{__MODULE__}|| query: #{query}"
    _resp     = HTTPoison.get!(query).body |> Poison.decode!
    ## TODO : store to database

    :ok
  end

  defp create_query(source, sort_by) do
    @news_api_url <> "?" <> "source=" <> source <> "&sortBy=" <> sort_by <> "&apiKey=" <> @news_api_key
  end
end


