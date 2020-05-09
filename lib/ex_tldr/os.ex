defmodule Os do
  @moduledoc """
  Module to wrap functions of the `os` Erlang's module.
  """
  @doc """
  Wrapper for the `type` function.
  """
  def check_type() do
    case type do
      {:win32, :nt} -> "windows"
      {:unix, :sunos} -> "sunos"
      {:unix, :linux} -> "linux"
      {:unix, :darwin} -> "osx"
      _ -> "common"
    end
  end

  defp type, do: :os.type()
end
