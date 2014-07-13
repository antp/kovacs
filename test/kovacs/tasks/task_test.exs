defmodule Kovacs.Task.Test do
  use ExUnit.Case

  test "it will not find the test file" do
    expected = {:error, "\e[35mTest file for: missing.ex does not exist.\e[39m"}

    assert expected == Kovacs.Tasks.Run.run_file("missing.ex")
  end

  test "it will locate the test file" do
    expected = {:ok, "test/kovacs/tasks/task_test.exs", "\e[34mRunning test file: test/kovacs/tasks/task_test.exs\e[39m"}

    assert expected == Kovacs.Tasks.Run.run_file("test/kovacs/tasks/task_test.exs")
  end

end