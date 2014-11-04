defmodule Kovacs.Cli do

  @fswatch_path "/usr/local/bin/fswatch"

  def main(args) do
    run(args)
  end

  def run([]) do
    print_cmds
    IO.puts "\r\nWatching default locations."
    Kovacs.watch(["./lib", "./test"])
    do_run
  end

  def run(args) do
    print_cmds

    case ensure_fswatch do
      true ->
        case Kovacs.Config.load(List.first(args)) do
          :ok ->
            Kovacs.Cfg.configure
            IO.puts "Watching..."
            do_run
          :stop ->
            IO.puts "Exiting..."
          end
      _ ->
        IO.puts "\e[31mUnable to locate fswatch binary at #{@fswatch_path}\e[39m"
      end
  end

  defp ensure_fswatch do
    File.exists?(@fswatch_path)
  end

  defp print_cmds do
    IO.puts "\r\n(I) toggle run integration test default: On"
    IO.puts "(Q)uit"

    IO.puts "(H)elp - show this menu"
    IO.puts "\r\n\e[31mImportant:\e[39m Please use the q command to exit cleanly."
    IO.puts "\r\n\r\n---------------------------\r\n"
  end

  defp do_run() do
    raw_cmd = IO.gets('')
    raw_cmd = String.downcase(raw_cmd)

    process_cmd(raw_cmd)
  end

  defp process_cmd("q\n") do
    # ensure all fswatch processes are terminated
    Kovacs.Watcher.Supervisor.unload_children
    IO.puts "Bye"
  end

  defp process_cmd("i\n") do
    Kovacs.Runner.Proc.toggle_run_integration
    do_run
  end

  defp process_cmd(_) do
    do_run
  end
end
