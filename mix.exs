defmodule Tempo.Network.MixProject do
  use Mix.Project

  # Erlang/OTP 27 is the oldest release Tempo is built and tested on.
  if String.to_integer(System.otp_release()) < 27 do
    Mix.raise(
      "ex_tempo_network requires Erlang/OTP 27 or later: OTP #{System.otp_release()} detected."
    )
  end

  @version "1.0.0-dev"

  def project do
    [
      app: :ex_tempo_network,
      version: @version,
      name: "Tempo Network",
      source_url: "https://github.com/elixir-tempo/tempo_network",
      elixir: "~> 1.17",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      docs: docs(),
      description: description(),
      package: package(),
      test_coverage: [ignore_modules: [~r/Error$/, Tempo.Network.ChronoLog]],
      dialyzer: [
        plt_add_apps: [:ex_tempo],
        flags: [:error_handling, :unknown, :underspecs, :extra_return, :missing_return]
      ]
    ]
  end

  def description do
    "Chronological networks and dependency scheduling over Tempo: periods known " <>
      "only relative to one another, the relations between them, and what follows."
  end

  def package do
    [
      maintainers: ["Kip Cole"],
      licenses: ["Apache-2.0"],
      links: %{
        "GitHub" => "https://github.com/elixir-tempo/tempo_network",
        "Readme" => "https://github.com/elixir-tempo/tempo_network/blob/v#{@version}/README.md",
        "Changelog" =>
          "https://github.com/elixir-tempo/tempo_network/blob/v#{@version}/CHANGELOG.md"
      },
      files: ["lib", "guides", "mix.exs", "README.md", "CHANGELOG.md", "LICENSE.md"]
    ]
  end

  def application do
    [extra_applications: [:logger]]
  end

  def docs do
    [
      source_ref: "v#{@version}",
      main: "readme",
      extras: ["README.md", "LICENSE.md", "CHANGELOG.md"] ++ Path.wildcard("guides/*.md"),
      formatters: ["html", "markdown"],
      groups_for_modules: [
        Networks: ~r/^Tempo\.Network(\.(TimePeriod|Relation|Solver|Qualitative))?$/,
        Scheduling: ~r/^Tempo\.Schedule(\.ScheduledTask)?$/
      ]
    ]
  end

  defp deps do
    [
      {:ex_tempo, github: "elixir-tempo/tempo", branch: "main"},
      {:ex_doc, "~> 0.38", only: [:dev, :test, :release], optional: true, runtime: false},
      {:dialyxir, "~> 1.4", only: [:dev, :test], runtime: false},
      {:credo, "~> 1.7", only: [:dev, :test], runtime: false},
      {:ex_slop, "~> 0.1", only: [:dev, :test], runtime: false},
      {:stream_data, "~> 1.0", only: [:dev, :test], runtime: false},
      {:tz, "~> 0.28"}
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]
end
