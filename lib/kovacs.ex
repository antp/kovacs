defmodule Kovacs do
  use Application

  def start(_type, _args) do
    Kovacs.Supervisor.start_link
  end

  def watch(dir_to_watch) do
    Kovacs.Watcher.Proc.create(dir_to_watch)
  end
end
