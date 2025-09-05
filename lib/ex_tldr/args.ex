defmodule ExTldr.Args do
  @moduledoc """
  Module for parsing command-line arguments.
  """

  @doc """
  Parses command-line arguments and returns the parsed options.
  """
  def parse(args) do
    options = OptionParser.parse(args, switches: [help: :boolean], aliases: [h: :help])

    case options do
      {[help: true], _, _} -> :help
      {_, [], _} -> :help
      {_, os_term, _} -> os_term
    end
  end
end