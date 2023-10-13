defmodule GenContent.Parser do
  @moduledoc """
  Parses file content.
  """

  alias GenContent.Content

  @doc """
  Returns a `Content` struct given a file's contents (`text`) and
  name (`file_name`).
  """
  @callback compile(text :: String.t(), file_name :: String.t()) :: Content.t()

  @doc """
  Compares two content structs.
  """
  @callback sort(Content.t(), Content.t()) :: boolean()
end
