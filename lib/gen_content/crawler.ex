defmodule GenContent.Crawler do
  @moduledoc false

  require Logger

  alias GenContent.Content

  @doc """
  Gets a list of files on the `content_path` from the given store, compiles
  each file found, and returns a sorted list of compiled files.
  """
  @spec crawl(module()) :: list(Content.t())
  def crawl(nil), do: {:ok, []}

  def crawl(store) do
    content_path = store.content_path()
    parser = store.parser()

    content_path
    |> get_files()
    |> Enum.map(fn file_name ->
      Task.async(fn -> parse_file(content_path, file_name, parser) end)
    end)
    |> Enum.map(&Task.await/1)
    |> Enum.sort(&parser.sort/2)
  end

  defp get_files(content_path) do
    if File.exists?(content_path) do
      File.ls!(content_path)
    else
      Logger.error("The content path #{content_path} doesn't exist.")
      []
    end
  end

  defp parse_file(content_path, file_name, parser) do
    content_path
    |> Path.join(file_name)
    |> File.read!()
    |> parser.compile(file_name)
  end
end
