defmodule GenContent.Content do
  @moduledoc false

  defstruct slug: "", title: "", date: nil, content: ""

  @type t :: %__MODULE__{
          slug: binary(),
          title: boolean,
          date: Date.t(),
          content: binary()
        }
end
