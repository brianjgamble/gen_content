defmodule GenContent.Content do
  @moduledoc """
  A struct representing content.

  Provides a consistent interface for a parsed content file.

  Fields:
    * `:slug` - a slugified version of the title
    * `:title` - the name of the content
    * `:date` - the date of the content
    * `:text` - the text of the content
    * `:tags` - describes the content
  """

  defstruct slug: "", title: "", date: nil, text: "", tags: []

  @type t :: %__MODULE__{
          slug: String.t(),
          title: String.t(),
          date: Date.t() | nil,
          text: String.t(),
          tags: list(String.t())
        }

  @doc """
  Creates a new `GenContent.Content` struct from the given map.

  When creating the struct, the title is slugified and the date should be an
  ISO 8601 string.
  """
  @spec new(map()) :: t()
  def new(data \\ %{}) do
    %__MODULE__{}
    |> struct(transform(data))
    |> validate!()
  end

  @spec transform(map()) :: map()
  defp transform(data) when data == %{}, do: %{}

  defp transform(data) do
    title = String.trim(data.title)

    %{
      title: title,
      slug: slugify(title),
      date: Date.from_iso8601!(data.date),
      text: data.text,
      tags: data.tags
    }
  end

  @spec slugify(String.t()) :: String.t()
  defp slugify(string) do
    string
    |> String.normalize(:nfd)
    |> String.replace(~r{[^\w\s]+}u, "")
    |> String.replace(~r{[\s]+}, "-")
    |> String.downcase()
  end

  @spec validate!(t()) :: t()
  defp validate!(%__MODULE__{} = struct) do
    case Enum.reject(struct.tags, &is_binary/1) do
      [] -> struct
      _ -> raise ArgumentError, message: "tags should be a list of strings"
    end
  end
end
