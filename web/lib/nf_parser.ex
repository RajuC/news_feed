defmodule NewsFeed.NfParser do


  alias NewsFeed.{NfStore}

# %{"articles" => [], "sortBy" => "top", "source" => "cnn", "status" => "ok"}

  def frame_articles_and_store(articles_map) do
    Enum.each(articles_map["articles"], fn(article) ->
      new_map    =
        %{"source_id"       => articles_map["source"],
          "article_type" => articles_map["sortBy"]
          }
      article |> frame_article_keys
              |> Map.merge(new_map)
              |> validate_article
              |> NfStore.store_article
    end)  
  end



  def frame_sources_and_store(%{"sources" => sources}) do
    Enum.each(sources, fn(source) ->
      source |> frame_source_keys
             |> NfStore.store_source
    end)
  end


  def validate_article(article) do
    article |> validate_author
            |> validate_published_at
            |> validate_description
  end

  def now() do
    DateTime.utc_now |> DateTime.to_string
  end

  defp frame_article_keys(article) do
    post_id = get_unique_id()
    modfied_article_map = 
      %{"published_at"  => article["publishedAt"],
        "url_to_image"  => article["urlToImage"],
        "post_id"       => post_id}
    article |> Map.merge(modfied_article_map)
            |> Map.drop(["publishedAt", "urlToImage"])
  end


  defp frame_source_keys(source) do
    modified_source_map =
      %{"source_id"     => source["id"],
        "urls_to_logos" => source["urlsToLogos"],
        "source_types"  => source["sortBysAvailable"]
      }
    source |> Map.merge(modified_source_map)
           |> Map.drop(["id", "urlsToLogos", "sortBysAvailable"])
  end

  defp get_unique_id() do
    date = Date.utc_today |> Date.to_string |> String.replace("-", "")
    date <> rand_num(12, "")
  end

  defp rand_num(0, num_str), do: num_str
  defp rand_num(len, num_str) do
    rand_number = 10 |> :rand.uniform |> Integer.to_string
    rand_num(len - 1, num_str <> rand_number)
  end

  defp validate_author(%{"author" => author} = article) when (author == "") or (author == nil) do
    article |> Map.merge(%{"author" => "anonymous"})
  end
  defp validate_author(article), do: article


  defp validate_published_at(%{"published_at" => pub_at} = article) when (pub_at == "") or (pub_at == nil) do
    article |> Map.merge(%{"published_at" => "not available"})
  end
  defp validate_published_at(article), do: article


  defp validate_description(%{"description" => des} = article) when (des == "") or (des == nil) do
    article |> Map.merge(%{"description" => "not available"})
  end
  defp validate_description(article), do: article

end

