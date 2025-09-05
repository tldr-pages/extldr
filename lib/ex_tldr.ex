defmodule ExTldr do
  @moduledoc """
  Documentation for ExTldr, an Elixir client for tldr-pages.
  """

  @doc """
  Wrapper for the CLI of the ExTldr client. 
  """
  def main(args) do
    args
    |> ExTldr.Args.parse()
    |> process()
  end

  defp process(:help) do
    ExTldr.Output.help()
  end

  defp process(os_term) do
    case length(os_term) do
      1 ->
        [os, term] = Enum.join([ExTldr.OS.check_type(), os_term], " ") |> String.split()
        describe(os, term)

      2 ->
    [os, term] = Enum.join(os_term, " ") |> String.split()
        describe(os, term)
    end
  end

  defp describe(os, term) do
    case HTTPoison.get("https://raw.githubusercontent.com/tldr-pages/tldr/main/pages/#{os}/#{term}.md") do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        ExTldr.Output.show_content(body)

      {:ok, %HTTPoison.Response{status_code: 404}} ->
        ExTldr.Output.not_found(os, term)

        case HTTPoison.get("https://raw.githubusercontent.com/tldr-pages/tldr/main/pages/common/#{term}.md") do
          {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
            ExTldr.Output.show_content(body)

          {:ok, %HTTPoison.Response{status_code: 404}} ->
            ExTldr.Output.common_not_found(term)

          {:error, %HTTPoison.Error{reason: reason}} ->
            handle_error(reason)
    end

      {:error, %HTTPoison.Error{reason: reason}} ->
        handle_error(reason)
    end
  end

  defp handle_error(:nxdomain) do
    raise ExTldr.NoInternetConnectionError
  end

  defp handle_error(reason) do
    raise ExTldr.UnexpectedError, reason
  end
end
