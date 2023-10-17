<p align="center">
  <img width="300" src="gen_content_logo.png" alt="Logo">
</p>

![GitHub](https://img.shields.io/github/license/brianjgamble/gen_content)

# GenContent

A simple, content management tool that uses GenServer to store and retrieve
compiled content.

## Installation

Add `:gen_content` to the list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:gen_content, github: "brianjgamble/gen_content"}
  ]
end
```

## Usage

To load content in your application, implement a `GenContent.Store` and a 
`GenContent.Parser`.  Then, add an entry for your content in the list of 
supervisor children in `application.ex`.

### Example

Let's imagine you have blog content with a custom store of `MyApp.BlogStore`.

We'll add a GenContent entry to the list of children so the blog content will 
be loaded and parsed.  The entry is a two element tuple containing the module 
`GenContent` and another tuple with a name (an `atom`) for the content and 
the module for the implemented content store (`GenContent.Store`).

```elixir
# Usually in application.ex within the function start

children = [
  # other workers
  {GenContent, {:blog, MyApp.BlogStore}}
]
```

To access your content, you have two functions available:

- `list_content/1`
- `fetch_content/2`

To list all of the blog content, provide the name of your content: 
```elixir
GenContent.list_content(:blog)
```

To fetch blog content, provide the name and the content's `slug` (see
`GenContent.Content`): 
```elixir
GenContent.fetch_content(:blog, "first-post")
```

