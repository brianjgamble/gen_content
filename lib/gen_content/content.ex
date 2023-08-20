defmodule GenContent.Content do
  @moduledoc false

  defstruct slug: "", title: "", date: "", text: "", tags: []

  @type t :: %__MODULE__{
          slug: String.t(),
          title: String.t(),
          date: String.t(),
          text: String.t(),
          tags: List.t()
        }
end
