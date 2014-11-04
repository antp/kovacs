defmodule Kovacs.Watcher do

  @fswatch_path "fswatch"
  @max_line_length_for_each_event 2048

  def initialise(path) do
    paths = Enum.join(path, " ")

    port = Port.open({ :spawn, '#{@fswatch_path} #{paths}' },
        [:stderr_to_stdout, :in, :exit_status, :binary, :stream, { :line, @max_line_length_for_each_event }])

    {:os_pid, pid} = Port.info(port, :os_pid)

    Kovacs.Watcher.Data.create(port, pid, path)
  end

  def unload(state) do
    port = Kovacs.Watcher.Data.port(state)
    pid = Kovacs.Watcher.Data.pid(state)

    close_port(port, pid)
  end

  def get_changed_files(modified_file, active_port, state, on_changed_fn) do
    port = Kovacs.Watcher.Data.port(state)

    if active_port == port do
      if String.ends_with?(modified_file, [".ex", ".exs"]) do
        on_changed_fn.(modified_file)
      end
    end

    state
  end

  defp close_port(port, pid) do
    case port do
      nil ->
        :ok
      port ->
        Port.close(port)
        System.cmd("kill", ["#{pid}"], [])
    end
  end
end