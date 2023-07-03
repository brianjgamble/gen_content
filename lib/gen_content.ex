defmodule GenContent do
  @moduledoc """
  Documentation for `GenContent`.
  """
  alias GenContent.Crawler
  use GenServer

  #def start_link(module, _init_arg) do
  #  GenServer.start_link(__MODULE__, :ok, name: __MODULE__)
  #end

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
  def list_content do
    GenServer.call(__MODULE__, {:list_content})
  end

  @doc """
  Fetches a single piece of content.

  Returns `:not_found` if the content does not exist.
  """
  def fetch_content(slug) do
    GenServer.call(__MODULE__, {:fetch_content, slug})
  end
end
