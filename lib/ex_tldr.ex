defmodule ExTldr do
  @moduledoc """
  Documentation for ExTldr, an Elixir client for tldr-pages.
  """

  @doc """
  Wrapper for the CLI of the ExTldr client. 
  """
  def main(args) do
    args
    |> parse_args
    |> process
  end

  defp parse_args(args) do
    options = OptionParser.parse(args, switches: [help: :boolean], aliases: [h: :help])

    case options do
      {[help: true], _, _} -> :help
      {_, [], _} -> :help
      {_, os_term, _} -> os_term
    end
  end

  defp process(:help) do
    IO.puts("""
    ExTldr is an Elixir client for tldr-pages

    Usage:
      - Search Linux command `adduser`:
      `extldr linux adduser`

      - Search a common command, `chroot`, in different operating system:
      `extldr common chroot`

      - Search Linux command `cat`, available in common pages due it is available in different operating systems:
      `extldr linux cat`

    If you have an issue or a suggestion, you can post a new issue on https://github.com/ivanhercaz/extldr
    """)
  end

  defp process(os_term), do: describe(os_term)

  defp process_url(os, term) do
    "https://raw.githubusercontent.com/tldr-pages/tldr/master/pages/#{os}/#{term}.md"
  end

  defp describe(os_term) do
    IO.puts(process(:help))
    [os, term] = Enum.join(os_term, " ") |> String.split()

    case HTTPoison.get(process_url(os, term)) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        IO.puts(body)

      {:ok, %HTTPoison.Response{status_code: 404}} ->
        IO.puts(
          "Term \"#{term}\" not found on \"#{os}\" pages\nExTldr is looking on \"common\" pages."
        )

        case HTTPoison.get(process_url("common", term)) do
          {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
            IO.puts(body)

          {:ok, %HTTPoison.Response{status_code: 404}} ->
            IO.puts("Term not found on \"common\" pages.")
        end

      {:error, %HTTPoison.Error{reason: reason}} ->
        IO.inspect(reason)
    end
  end
end
