defmodule Kovacs.Cli do

  @fswatch_path "/usr/local/bin/fswatch"

  def main(args) do
    run(args)
  end

  def run([]) do
    print_cmds
    IO.puts "\r\n\e[31mMissing control file!\e[39m"
  end

  def run(args) do
    print_cmds

    case ensure_fswatch do
      true ->
        case Kovacs.Config.load(List.first(args)) do
          :ok ->
            Kovacs.Cfg.configure
            IO.puts "Watching..."
            run
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
    IO.puts "\r\n(Q)uit"

    IO.puts "(H)elp - show this menu"
    IO.puts "\r\n\e[31mImportant:\e[39m Please use the q command to exit cleanly."
    IO.puts "\r\n\r\n---------------------------\r\n"
  end

  defp run() do
    raw_cmd = IO.gets('')

    process_cmd(raw_cmd)
  end

  defp process_cmd("q\n") do
    # ensure all fswatch processes are terminated
    Kovacs.Watcher.Supervisor.unload_children
    IO.puts "Bye"
  end

  defp process_cmd(_) do
    run
  end

end