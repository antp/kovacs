defmodule Kovacs.Watcher.Proc do
  use GenServer

  def start_link() do
    :gen_server.start_link(__MODULE__, Kovacs.Watcher.Data.new, [])
  end

  def create(dir_to_watch) do
    IO.puts "Watching #{dir_to_watch}"
    {:ok, pid} = Kovacs.Watcher.Supervisor.create_child()

    :gen_server.call pid, {:watch, dir_to_watch}
  end

  def unload(pid) do
    :gen_server.call pid, {:unload}
  end

  def handle_call({:watch, path}, _from, _state) do
    state = Kovacs.Watcher.initialise(path)

    {:reply, :ok, state}
  end

  def handle_call({:unload}, _from, state) do
    Kovacs.Watcher.unload(state)

    {:reply, :ok, Kovacs.Watcher.Data.new}
  end

  def handle_info({ active_port, {:data, {:eol, modified_file}} }, state) do
    on_changed_fn = fn(modified_files) ->
      Kovacs.Runner.Proc.run_tests(modified_files)
    end

    state = Kovacs.Watcher.get_changed_files(modified_file, active_port, state, on_changed_fn)


    {:noreply, state}
  end

  def terminate(reason, state) do
    path = Kovacs.Watcher.Data.path(state)

    IO.puts "Fatal error. No longer watching the path #{path}. #{reason}"

    Kovacs.Watcher.unload(state)
    :ok
  end
end

