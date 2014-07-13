defmodule Kovacs.Supervisor do
  use Supervisor

  def start_link do
    :supervisor.start_link(__MODULE__, [])
  end

  def init([]) do
    children = [
      # Define workers and child supervisors to be supervised
      supervisor(Kovacs.Watcher.Supervisor, []),
      worker(Kovacs.Runner.Proc, [])
    ]

    # See http://elixir-lang.org/docs/stable/Supervisor.Behaviour.html
    # for other strategies and supported options
    supervise(children, strategy: :one_for_one)
  end

  def start_child(dir_to_watch) do
    :supervisor.start_child(__MODULE__, dir_to_watch)
  end
end
