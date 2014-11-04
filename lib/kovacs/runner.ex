defmodule Kovacs.Runner do
  def run_if_ready(fifo) do
    if Kovacs.Fifo.has_items?(fifo) do
      {entry, fifo} = Kovacs.Fifo.next(fifo)

      run(entry)

      fifo
    else
      fifo
    end
  end

  defp run({:file, file}) do
    IO.puts "\e[34mRunning test file: #{file}\e[39m"

    Port.open({:spawn, 'mix test --exclude ignore --exclude pending #{file}'},
      [:stderr_to_stdout, :in, :exit_status, :binary, :stream, { :line, 1 }])
  end

  defp run({:integration, file}) do
    IO.puts "\e[34mRunning integration test file: #{file}\e[39m"

    Port.open({:spawn, 'mix test --exclude ignore --exclude pending #{file}'},
      [:stderr_to_stdout, :in, :exit_status, :binary, :stream, { :line, 1 }])
  end
end