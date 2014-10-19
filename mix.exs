defmodule Kovacs.Mixfile do
  use Mix.Project

  def project do
    [ app: :kovacs,
      version: version,
      elixir: "~> 1.0",
      escript: escript,
      deps: deps,
      description: description,
      package: package
    ]
  end


  def version do
    String.strip(File.read!("VERSION"))
  end

  # Configuration for the OTP application
  def application do
    [mod: { Kovacs, [] }]
  end

  def escript do
    [main_module: Kovacs.Cli]
  end

  # Returns the list of dependencies in the format:
  # { :foobar, git: "https://github.com/elixir-lang/foobar.git", tag: "0.1" }
  #
  # To specify particular versions, regardless of the tag, do:
  # { :barbat, "~> 0.1", github: "elixir-lang/barbat" }
  defp deps do
    []
  end

defp description do
    """
    Kovacs - A simple ExUnit test runner

    It will monitor the file system and run test files when it detects changes.
    """
  end

  defp package do
    [
      files:        [ "lib", "priv", "mix.exs", "README.md", "LICENCE.txt" ],
      contributors: [ "Antony Pinchbeck"],
      licenses:     [ "apache 2 license" ],
      links:        %{
                       "GitHub" => "https://github.com/antp/kovacs",
                    }
    ]
  end
end
