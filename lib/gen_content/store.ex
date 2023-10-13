defmodule GenContent.Store do
  @moduledoc """
  A store that knows the location of the content and the parser
  that can handle the content.
  """

  @doc """
  Returns the file path of the content.
  """
  @callback content_path() :: String.t()

  @doc """
  Returns the content parser for the store.
  """
  @callback parser() :: module()
end
