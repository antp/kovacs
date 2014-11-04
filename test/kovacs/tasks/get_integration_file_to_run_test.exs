defmodule Get.Integartion.File.To.Run.Test do
	use ExUnit.Case


  test "it will return the integration file for the application at the top level directory" do
    integration_file = "/dir/kovacs/test/app_test.exs"
    file = "/dir/kovacs/test/some.ex"
    cwd = "/dir/kovacs"

    assert integration_file == Kovacs.Get.Integration.File.To.Run.call(file, cwd)
  end

	test "it will return the integration file for the changed file" do
    integration_file = "/kovacs/test/sub_dir/sub_dir_test.exs"
    file = "/kovacs/test/sub_dir/some.ex"
    cwd = "/kovacs"

		assert integration_file == Kovacs.Get.Integration.File.To.Run.call(file, cwd)
	end
end