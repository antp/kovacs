defmodule Kovacs.Watcher.Supervisor do
  use Supervisor

  def start_link do
    :supervisor.start_link({:local, __MODULE__}, __MODULE__, [])
  end

  def init([]) do
    child_spec = [ worker(Kovacs.Watcher.Proc, [], restart: :temporary) ]
    # See http://elixir-lang.org/docs/stable/Supervisor.Behaviour.html
    # for other strategies and supported options
    supervise(child_spec, strategy: :simple_one_for_one)
  end

  def create_child() do
    :supervisor.start_child(__MODULE__, [])
  end

  def unload_children do
    data = :supervisor.which_children(__MODULE__)

    Enum.each(data, fn({_, pid, _, _}) ->
      Kovacs.Watcher.Proc.unload(pid)
    end)
  end
end

