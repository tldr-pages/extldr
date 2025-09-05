defmodule ExTldr.HTTP do
  @moduledoc """
  Module for handling HTTP requests to the tldr-pages API.
  """

  @base_url "https://raw.githubusercontent.com/tldr-pages/tldr/main/pages"

  @doc """
  Fetches the tldr page for a given OS and command.
  """
  def fetch(os, term) do
    url = "#{@base_url}/#{os}/#{term}.md"
    HTTPoison.get(url)
  end
end