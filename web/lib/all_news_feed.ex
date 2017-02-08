defmodule NewsFeed.AllNewsFeed do
	
  # @post_url     Application.get_env(:news_feed, :post_url)
  # @access_token Application.get_env(:news_feed, :access_token)
  # @httpoison    Application.get_env(:news_feed, :httpoison)
  # @headers      [{"Content-Type", "application/json"},
  #                {"access-token", @access_token}]

  ## source and sort
  @news_sources [
                  # {"the-times-of-india", ["top", "latest"]},
                  # {"the-hindu",          ["top", "latest"]},
                  {"cnn",                ["top"]}
                ]

  require Logger
  alias NewsFeed.{NfHttp}

	def fetch_news_feed do
    Logger.info "#{__MODULE__}||news_feed started."
    Enum.each(@news_sources, fn({source, sort_by_list}) ->
      Enum.each(sort_by_list, fn(sort_by) ->
        source |> get_articles(sort_by)
      end)  
    end)
	end



  defp get_articles(source, sort_by) do
    Logger.info  "#{__MODULE__}|| source: #{source} || sort_by: #{sort_by}"
    NfHttp.get_http(source, sort_by)
  end

end