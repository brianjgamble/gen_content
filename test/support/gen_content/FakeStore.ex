defmodule GenContent.FakeStore do
  @moduledoc """
  A GenContent.Store used for testing.
  """

  @behaviour GenContent.Store

  @impl true
  def content_path do
    "test/support/content"
  end

  @impl true
  def parser, do: GenContent.FakeParser
end
