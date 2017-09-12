defmodule SSHEcho.Mixfile do
  use Mix.Project

  def project do
    [
      app: :ssh_echo,
      version: "0.1.0",
      source_url: "https://github.com/kerryb/ssh_echo",
      elixir: "~> 1.4",
      description: "Simple echo server for testing SSH clients",
      package: package(),
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      deps: deps(),
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: preferred_cli_env(),
      docs: [
        main: "readme",
        extras: ~w(README.md)
      ],
   ]
  end

  def application do
    [
      extra_applications: [:logger, :ssh],
      mod: {SSHEcho.Application, []},
    ]
  end

  defp deps do
    [
      {:ex_doc, "~> 0.16", only: :dev},
      {:excoveralls, "~> 0.7", only: :test},
      {:sshex, "~> 2.2"},
    ]
  end

  defp preferred_cli_env do
    [
      coveralls: :test,
      "coveralls.detail": :test,
      "coveralls.post": :test,
      "coveralls.html": :test,
     ]
  end

  defp package do
    [
      maintainers: ["Kerry Buckley"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/kerryb/ssh_echo"},
    ]
  end
end
