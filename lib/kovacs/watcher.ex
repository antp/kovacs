defmodule Kovacs.Watcher do

  @fswatch_path "./fswatch"
  @max_line_length_for_each_event 255

  def initialise(path) do
    port = Port.open({ :spawn, '#{@fswatch_path} ./#{path} \'echo "file event"\'' },
        [:stderr_to_stdout, :in, :exit_status, :binary, :stream, { :line, @max_line_length_for_each_event }])

    {:os_pid, pid} = Port.info(port, :os_pid)

    files = Kovacs.Files.Finder.get_files(path)

    Kovacs.Watcher.Data.create(port, pid, path, files)
  end

  def unload(state) do
    port = Kovacs.Watcher.Data.port(state)
    pid = Kovacs.Watcher.Data.pid(state)

    close_port(port, pid)
  end

  def get_changed_files(active_port, state, on_changed_fn) do
    port = Kovacs.Watcher.Data.port(state)

    if active_port == port do
      path = Kovacs.Watcher.Data.path(state)

      new_files = Kovacs.Files.Finder.get_files(path)

      files = Kovacs.Watcher.Data.files(state)

      modified_files = get_modified_files(new_files, files)

      on_changed_fn.(modified_files)
    end

    Kovacs.Watcher.Data.update_files(state, new_files)
  end

  defp close_port(port, pid) do
    case port do
      nil ->
        :ok
      port ->
        Port.close(port)
        System.cmd("kill -9 #{pid}")
    end
  end

  defp get_modified_files(new_files, old_files) do
    Enum.filter new_files, fn({ path, new_date }) ->
      case List.keyfind(old_files, path, 0) do
        nil ->
          true
        {_, old_date} ->
          new_date != old_date
      end
    end
  end
end