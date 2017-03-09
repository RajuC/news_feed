defmodule NewsFeed.Mixfile do
  use Mix.Project

  def project do
    [app: :news_feed,
     version: "0.0.1",
     elixir: "~> 1.2",
     elixirc_paths: elixirc_paths(Mix.env),
     compilers: [:phoenix, :gettext] ++ Mix.compilers,
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     aliases: aliases(),
     deps: deps()]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [mod: {NewsFeed, []},
     applications: [:phoenix, :phoenix_pubsub, :phoenix_html, :cowboy, :logger, :gettext,
                    :phoenix_ecto, :mongodb_ecto, :httpoison, :quinn, :quantum, :credo, :sparkpost]]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "web", "test/support"]
  defp elixirc_paths(_),     do: ["lib", "web"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [{:phoenix,             "~> 1.2.1"},
     {:phoenix_pubsub,      "~> 1.0"},
     {:phoenix_ecto,        "~> 1.0", override: true},
     {:mongodb_ecto,        github: "michalmuskala/mongodb_ecto"},
     {:phoenix_html,        "~> 2.1.0", override: true},
     {:phoenix_live_reload, "~> 1.0", only: :dev},
     {:credo,               "~> 0.5", only: [:dev, :test]},
     {:gettext,             "~> 0.11"},
     {:cowboy,              "~> 1.0"},
     {:exvcr,               "~> 0.8.2", only: :test},       ## used for test cases of http
     {:httpoison,           "~> 0.9.0"},                    ## json encode and decode and http req/ resp
     {:exrm,                "~> 1.0.8"},                    ## for releases
     {:quinn, git:          "git@github.com:nhu313/Quinn"}, ## xml parser
     {:quantum,             ">= 1.8.1"               },     ##  cron like job scheduler
     {:ibrowse, github:     "cmullaparthi/ibrowse", tag: "v4.1.2", override: true},
     {:sparkpost,           "~> 0.3.0"},
     {:credo,               "~> 0.5", only: [:local, :dev, :test]},    ## for code style checker
     {:poison, "~> 3.0", override: true}
   ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to create, migrate and run the seeds file at once:
  #
  #     $ mix ecto.setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    ["ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
     "ecto.reset": ["ecto.drop", "ecto.setup"],
     "test": ["ecto.create --quiet", "ecto.migrate", "test"]]
  end
end
