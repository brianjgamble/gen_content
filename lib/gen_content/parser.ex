defmodule GenContent.Parser do
  @moduledoc false

  alias GenContent.Content

  @doc """
  Compiles the content given the file text and file name.
  """
  @callback compile(binary(), binary()) :: Content.t()

  @doc """
  Compares content and returns a boolean.
  """
  @callback sort(Content.t(), Content.t()) :: boolean()
end
