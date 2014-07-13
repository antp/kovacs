defmodule Kovacs.Config do
  def load(cfg_file) do
    case File.exists?(cfg_file) do
      true ->
        Code.require_file(cfg_file)
        :ok
      _ ->
        IO.puts "\e[31mThe configuration file #{cfg_file} was not found.\e[39m"
        :stop
    end
  end
end