<p align="center">
  <img width="300" src="gen_content_logo.png" alt="Logo">
</p>

![GitHub](https://img.shields.io/github/license/brianjgamble/gen_content)

# GenContent

A simple, content management tool that uses GenServer to store and retrieve
compiled content.

## Installation

Add `:gen_content` to the list of dependencies `mix.exs`:

```elixir
def deps do
  [
    {:gen_content, github: "brianjgamble/gen_content"}
  ]
end
```

## Usage

To load content in your application, implement a `GenContent.Store` and a 
`GenContent.Parser`.  Then, add your custom store(s) to the list of supervisor 
children in `application.ex`.

Here's an example: let's assume you have blog content with a custom store 
called `MyApp.BlogStore`.

We'll add the store to the children list with an id of `:content_1` and a 
name of `:blog`:

```elixir
# Usually in application.ex within the function start

children = [
  # ... other workers ...
  GenContent.child_specification(:content_1, :blog, MyApp.BlogStore)
]
```

To access the list of blog posts, use `list_content/1` with the name given  
in the child specification:
```elixir
GenContent.list_content(:blog)
```

To fetch a specific blog, provide the name and the `slug` of the blog post:
```elixir
GenContent.fetch_content(:blog, slug)
```

