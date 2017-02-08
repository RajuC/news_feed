defmodule NewsFeed.AllNewsFeed do
	
  # @post_url     Application.get_env(:news_feed, :post_url)
  # @access_token Application.get_env(:news_feed, :access_token)
  # @httpoison    Application.get_env(:news_feed, :httpoison)
  # @headers      [{"Content-Type", "application/json"},
  #                {"access-token", @access_token}]
  @news_api_key Application.get_env(:news_feed, :news_api_key)
  @news_api_url Application.get_env(:news_feed, :news_api_url)

  ## source and sort
  @news_sources [
                  {"the-times-of-india", ["top", "latest"]},
                  {"the-hindu",          ["top", "latest"]},
                  {"cnn",                ["top"]}
                ]

  require Logger            

	def fetch_news_feed do
		IO.inspect "i am the news feed...."
    Enum.each(@news_sources, fn({source, sort_by_list}) ->
      Enum.each(sort_by_list, fn(sort_by) ->
        source |> get_articles(sort_by)
      end)  
    end)
	end



  defp get_articles(source, sort_by) do
    date_time = DateTime.to_string(DateTime.utc_now())
    "#{date_time} #{__MODULE__}.news_feed started."
    IO.inspect "========================== source: #{source}"
    IO.inspect "========================== sort_by: #{sort_by}"
    :ok
  end




end