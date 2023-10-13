defmodule GenContent.Content do
  @moduledoc """
  A struct representing content.
  """

  defstruct slug: "", title: "", date: nil, text: "", tags: []

  @type t :: %__MODULE__{
          slug: String.t(),
          title: String.t(),
          date: Date.t() | nil,
          text: String.t(),
          tags: list()
        }
end
