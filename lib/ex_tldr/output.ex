defmodule ExTldr.Output do
  @moduledoc """
  Module for formatting and displaying output.
  """

  @doc """
  Displays the help text.
  """
  def help() do
    IO.puts("""
    ExTldr is an Elixir client for tldr-pages

    Usage:
      - Search command `feh` in the pages of your current operating system:
      `extldr feh`

      - Search Linux command `adduser`:
      `extldr linux adduser`

      - Search a common command, `chroot`, in different operating system:
      `extldr common chroot`

      - Search Linux command `cat`, available in common pages due it is available in different operating systems:
      `extldr linux cat`

    If you have an issue or a suggestion, you can post a new issue on https://github.com/tldr-pages/extldr
    """)
  end

  @doc """
  Displays the content of a tldr page.
  """
  def show_content(body) do
    IO.puts(body)
  end

  @doc """
  Displays a not found message.
  """
  def not_found(os, term) do
    IO.puts("Term \"#{term}\" not found on \"#{os}\" pages\nExTldr is looking on \"common\" pages.")
  end

  @doc """
  Displays a common not found message.
  """
  def common_not_found(term) do
    IO.puts("Term \"#{term}\" not found on \"common\" pages.")
  end
end