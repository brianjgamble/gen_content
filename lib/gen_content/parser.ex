defmodule GenContent.Parser do
  @moduledoc """
  Parses file content.
  """

  alias GenContent.Content

  @doc """
  Returns a `GenContent.Content` struct compiled from the given string.
  """
  @callback compile(String.t()) :: Content.t()

  @doc """
  Compares two content structs.
  """
  @callback sort(Content.t(), Content.t()) :: boolean()
end
