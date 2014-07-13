defmodule Kovacs.Tasks.Run do

  def run_file(file) do
    test_file = locate_test_file(file)

    test_file_exists = File.exists?(test_file)

    run_tests_file(test_file_exists, test_file, file)
  end

  defp run_tests_file(false, _test_file, file) do
    {:error, "\e[35mTest file for: #{file} does not exist.\e[39m"}
  end

  defp run_tests_file(true, test_file, _file) do
    {:ok, test_file, "\e[34mRunning test file: #{test_file}\e[39m"}
  end

  defp locate_test_file(file) do
   case file =~ ~r/_test.exs/ do
      true ->
        file
      _ ->
        file_base = Regex.run(~r/[^(lib)][^\.]+/, file)
        "test#{file_base}_test.exs"
    end
  end
end