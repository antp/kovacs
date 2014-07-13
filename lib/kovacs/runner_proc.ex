defmodule Kovacs.Runner.Proc do
  use GenServer

  def start_link do
    :gen_server.start_link({:local, __MODULE__ }, __MODULE__, Kovacs.Fifo.new, [])
  end

  def run_tests(modified_files) do
    :gen_server.cast __MODULE__, {:run_tests, modified_files}
  end


  def handle_cast({:run_tests, modified_files}, fifo) do
    fifo = Enum.reduce(modified_files, fifo, fn({file, _}, fifo) ->
      Kovacs.Fifo.add(fifo, file)
    end)

    fifo = Kovacs.Runner.run_if_ready(fifo)

    {:noreply, fifo}
  end

  def handle_info({_active_port, {:data, {:noeol, msg}} }, fifo) do
    :io.put_chars(msg)

    {:noreply, fifo}
  end

  def handle_info({_active_port, {:data, {:eol, msg}} }, fifo) do
    :io.put_chars(msg)
    :io.put_chars("\n")

    {:noreply, fifo}
  end

  def handle_info({_active_port, {:exit_status, _exit_status} }, fifo) do
    IO.puts "\r\n---------------------------\r\n"

    fifo = Kovacs.Runner.run_if_ready(fifo)

    {:noreply, fifo}
  end
end

