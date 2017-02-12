defmodule NewsFeed.NfSources do
	
  require Logger
  alias NewsFeed.{NfHttp, NfParser, Source, Repo}

  ## KEY IS ATOM HERE
  def sources(key) do
    Repo.all(Source) |> Enum.map(fn(source) -> Map.take(source, [:source_id, key]) end)
  end 

end