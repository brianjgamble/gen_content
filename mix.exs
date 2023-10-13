defmodule GenContent.MixProject do
  use Mix.Project

  def project do
    [
      app: :gen_content,
      version: "0.3.0",
      elixir: "~> 1.15",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:credo, "~> 1.7", only: :dev},
      {:dialyxir, "~> 1.4", only: [:dev], runtime: false}
    ]
  end
end
