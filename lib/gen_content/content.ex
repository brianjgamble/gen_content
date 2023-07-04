defmodule GenContent.Content do
  @moduledoc false

  defstruct slug: "", title: "", date: "", text: ""

  @type t :: %__MODULE__{
          slug: binary(),
          title: binary(),
          date: binary(),
          text: binary()
        }
end
