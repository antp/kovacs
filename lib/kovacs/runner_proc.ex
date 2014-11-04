defmodule Kovacs.Runner.Proc do
  use GenServer

  @failed_test 1

  def start_link do
    :gen_server.start_link({:local, __MODULE__ }, __MODULE__, {true, Kovacs.Fifo.new}, [])
  end

  def toggle_run_integration() do
    :gen_server.cast __MODULE__, :toggle_run_integration
  end

  def run_tests(modified_files) do
    :gen_server.cast __MODULE__, {:run_tests, modified_files}
  end

  def handle_cast(:toggle_run_integration, {run_integration, fifo}) do
    run_integration = case run_integration do
      true ->
        IO.puts "Integration tests OFF"
        false
      false ->
        IO.puts "Integration tests ON"
        true
    end

    {:noreply, {run_integration, fifo}}
  end

  def handle_cast({:run_tests, modified_file}, {run_integration, fifo}) do
    fifo = add_files_to_fifo(modified_file, run_integration, fifo)
    fifo = Kovacs.Runner.run_if_ready(fifo)

    {:noreply, {run_integration, fifo}}
  end

  def handle_info({_active_port, {:data, {:noeol, msg}} }, {run_integration, fifo}) do

    :io.put_chars(msg)

    {:noreply, {run_integration, fifo}}
  end

  def handle_info({_active_port, {:data, {:eol, msg}} }, {run_integration, fifo}) do
    :io.put_chars(msg)
    :io.put_chars("\n")

    {:noreply, {run_integration, fifo}}
  end

  def handle_info({_active_port, {:exit_status, exit_status} }, {run_integration, fifo}) do
    IO.puts "\r\n---------------------------\r\n"

    fifo = if @failed_test == exit_status do
      # failed test, so don't runn any others
      Kovacs.Fifo.new
    else
      Kovacs.Runner.run_if_ready(fifo)
    end

    {:noreply, {run_integration, fifo}}
  end

  defp add_files_to_fifo(file, run_integration, fifo) do
    file_to_run = Kovacs.Get.File.To.Run.call(file, System.cwd)
    test_file_exists = File.exists?(file_to_run)

    fifo = maybe_add_file(test_file_exists, {:file, file_to_run}, fifo)

    # run integration only if requested
    if run_integration do
      add_integration_test_file(file_to_run, fifo)
    else
      fifo
    end
  end

  defp add_integration_test_file(file, fifo) do
    file_to_run = Kovacs.Get.Integration.File.To.Run.call(file, System.cwd)

    test_file_exists = File.exists?(file_to_run)

    maybe_add_file(test_file_exists, {:integration, file_to_run}, fifo)
  end

  defp maybe_add_file(true, {:file, file}, fifo) do
    Kovacs.Fifo.add(fifo, {:file, file})
  end

  defp maybe_add_file(false, {:file, file}, fifo) do
    IO.puts "\e[35mTest file for: #{file} does not exist.\e[39m"
    fifo
  end

  defp maybe_add_file(true, {:integration, file}, fifo) do
    Kovacs.Fifo.add(fifo, {:integration, file})
  end

  defp maybe_add_file(false, {:integration, file}, fifo) do
    IO.puts "\e[35mIntegration test file: #{file} does not exist.\e[39m"
    fifo
  end
end

