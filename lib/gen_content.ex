defmodule GenContent do
  @moduledoc """
  Documentation for `GenContent`.
  """
  alias GenContent.Content
  alias GenContent.Crawler

  use GenServer

  def start_link(args) do
    GenServer.start_link(__MODULE__, args.store, name: args.name)
  end

  @impl true
  def init(store) do
    {:ok, Crawler.crawl(store)}
  end

  @impl true
  def handle_call({:list_content}, _from, contents) do
    {:reply, {:ok, contents}, contents}
  end

  @impl true
  def handle_call({:fetch_content, slug}, _from, contents) do
    case Enum.find(contents, fn content -> content.slug == slug end) do
      nil -> {:reply, :not_found, contents}
      content -> {:reply, {:ok, content}, contents}
    end
  end

  @doc """
  Returns the list of content.
  """
  @spec list_content(atom()) :: {:ok, list(Content.t())}
  def list_content(name) do
    GenServer.call(name, {:list_content})
  end

  @doc """
  Fetches a single piece of content.

  Returns `:not_found` if the content does not exist.
  """
  @spec fetch_content(atom(), binary()) :: Content.t() | :not_found
  def fetch_content(name, slug) do
    GenServer.call(name, {:fetch_content, slug})
  end
end
