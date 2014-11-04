defmodule Get.File.To.Run.Test do
	use ExUnit.Case

	test "it will return the test file when passed the test file" do
		file = "/kovacs/test/some_test.exs"
    cwd = "/kovacs"

		assert file == Kovacs.Get.File.To.Run.call(file, cwd)
	end

  test "it will return the test file when passed the file" do
    test_file = "/kovacs/test/some_test.exs"
    file = "/kovacs/lib/some.ex"
    cwd = "/kovacs"

    assert test_file == Kovacs.Get.File.To.Run.call(file, cwd)
  end

  test "it will return the test file when passed the file in a sub directory" do
    test_file = "/kovacs/test/sub_dir/some_test.exs"
    file = "/kovacs/lib/sub_dir/some.ex"
    cwd = "/kovacs"

    assert test_file == Kovacs.Get.File.To.Run.call(file, cwd)
  end
end