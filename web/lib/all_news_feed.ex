defmodule NewsFeed.AllNewsFeed do

  require Logger
  alias NewsFeed.{NfHttp, NfParser, NfRepo}



  def fetch_news_feed do
    Logger.info "#{__MODULE__}||Fetch news_feed started..."
    :source_types
      |>  NfRepo.get_sources("en")
      |>  Enum.each(fn(%{source_id: source, source_types: sort_by_list}) ->
            Logger.info "#{__MODULE__}||source : #{source} || type : #{sort_by_list}"
            sort_by_list
              |>  Enum.each(fn(sort_by) ->
                    source |> NfHttp.http_articles(sort_by)
                           |> NfParser.frame_articles_and_store
                  end)  
          end)
    Logger.info "Done Fetching news feed for all the channels...!!!"
  end


  def fetch_news_sources do
    Logger.info "#{__MODULE__}||Fetch_news_sources started..."
    NfHttp.http_sources |> NfParser.frame_sources_and_store
    Logger.info "Done fetching the sources.....!!!"
  end


##     Task.async(fn -> __MODULE__.fetch_news_sources() end)  ## temp function

end