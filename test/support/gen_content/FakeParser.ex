defmodule GenContent.FakeParser do
  @moduledoc """
  A GenContent.Parser used for testing.
  """
  @behaviour GenContent.Parser

  alias GenContent.Content

  @impl true
  def compile(_string) do
    Content.new()
  end

  @impl true
  def sort(content1, content2) do
    case Date.compare(content1, content2) do
      :lt -> false
      _ -> true
    end
  end
end
