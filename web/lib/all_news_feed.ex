defmodule NewsFeed.AllNewsFeed do

  require Logger
  alias NewsFeed.{NfHttp, NfParser, NfRepo, NfSubscriptions}

  def fetch_news_feed() do
    Logger.info "#{__MODULE__}||Fetch news_feed started..."
    :language
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


  def fetch_news_sources() do
    Logger.info "#{__MODULE__}||Fetch_news_sources started..."
    NfHttp.http_sources |> NfParser.frame_sources_and_store
    Logger.info "Done fetching the sources.....!!!"
  end


  def send_news_feed() do
    Logger.info "#{__MODULE__}||Sending news feed to all subscribers..."
    [post] = NfRepo.trending_posts |>Enum.take(1)
    resp = NfRepo.get_subscribers |> NfSubscriptions.send_message(post)
    IO.inspect "========================== resp"
    IO.inspect resp
    Logger.info "Done sending the news feed to subscribers.....!!!"
  end
##     Task.async(fn -> __MODULE__.fetch_news_sources() end)  ## temp function

end