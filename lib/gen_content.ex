defmodule GenContent do
  @moduledoc """
  Documentation for `GenContent`.
  """
  alias GenContent.Content
  alias GenContent.Crawler

  use GenServer

  @typedoc """
  A two element tuple representing the arguments required to start GenContent.

  The first element is the name and the second is the module for
  a `GenContent.Store`.

  ## Example

    {:blog, BlogStore}
  """
  @type args :: {atom(), module()}

  @spec child_specification(atom(), atom(), module()) :: map()
  def child_specification(id, name, store) do
    %{
      id: id,
      start: {GenContent, :start_link, [{name, store}]}
    }
  end

  @doc """
  Starts the GenServer process with the given arguments.
  """
  @spec start_link(args()) :: GenServer.on_start()
  def start_link({name, store}) when is_atom(name) do
    GenServer.start_link(__MODULE__, store, name: name)
  end

  def start_link(_args) do
    raise ArgumentError, message: "name must be an atom"
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
