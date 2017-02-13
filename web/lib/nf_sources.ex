defmodule NewsFeed.NfSources do

  require Logger
  alias NewsFeed.{NfHttp, NfParser, Source, Repo}

  ## KEY IS ATOM HERE
  def sources(key) do
    all_sources = Repo.all(Source)
    all_sources |> Enum.map(fn(source) -> Map.take(source, [:source_id, key]) end)
  end

end