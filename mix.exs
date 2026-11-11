defmodule Charityapidocs.MixProject do
  use Mix.Project

  # Sidebar groups. Order here is the order in the sidebar; each page belongs to one group.
  @guides [
    "src/main.md",
    "src/Authentication.md",
    "src/Errors.md",
    "src/MCP.md"
  ]
  @endpoints [
    "src/Organizations.md",
    "src/Public_Charity_Check.md",
    "src/Keys.md",
    "src/Data_Imports.md",
    "src/NTEE_Codes.md"
  ]

  def project do
    [
      app: :charityapidocs,
      version: "1.0.0",
      elixir: "~> 1.17",
      start_permanent: Mix.env() == :prod,
      build_embedded: Mix.env == :prod,
      deps: deps(),
      aliases: aliases(),

      # Docs
      name: "CharityAPI.org API Docs",
      source_url: "https://github.com/USER/PROJECT",
      homepage_url: "https://www.charityapi.org",
      docs: [
        logo: "images/logo_square.png",
        formatters: ["html"],
        # source_beam: "src",
        extra_section: "Documentation",
        extras: @guides ++ @endpoints,
        groups_for_extras: [Guides: @guides, Endpoints: @endpoints],
        api_reference: false,
        main: "main"
      ]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {Charityapidocs.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:plug_cowboy, "~> 2.7"},
      {:ex_doc, "~> 0.36.0"},
      {:makeup_json, "~> 0.1.0"}
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      docs: ["docs", &copy_static/1],
      "assets.deploy": ["docs"]
    ]
  end

  # Copies machine-readable files (openapi.yaml, llms.txt) from static/ into
  # the generated site so they are served from the docs root.
  defp copy_static(_args) do
    File.cp_r!("static", "doc")
  end
end
