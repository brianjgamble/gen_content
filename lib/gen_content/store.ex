defmodule GenContent.Store do
  @moduledoc false

  @doc """
  Returns a file path to content.
  """
  @callback content_path() :: binary()

  @doc """
  Returns the content parser for the store.
  """
  @callback parser() :: module()
end
