defmodule GenContent.Parser do
  @moduledoc false

  @doc """
  Compiles the content.
  """
  @callback compile(binary()) :: any()

  @doc """
  Compares content and returns a boolean.
  """
  @callback sort(any(), any()) :: boolean()
end
