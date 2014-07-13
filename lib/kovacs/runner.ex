defmodule Kovacs.Runner do
  def run_if_ready(fifo) do
    if Kovacs.Fifo.has_items?(fifo) do
      {file, fifo} = Kovacs.Fifo.next(fifo)

      case Kovacs.Tasks.Run.run_file(file) do
        {:error, msg} ->
          IO.puts msg
          IO.puts "\r\n---------------------------\r\n"
        {:ok, file_to_run, msg} ->
          IO.puts msg
          Port.open({ :spawn, 'mix test #{file_to_run}' },
            [:stderr_to_stdout, :in, :exit_status, :binary, :stream, { :line, 1 }])
      end
    end

    fifo
  end
end