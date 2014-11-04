defmodule Kovacs.Get.Integration.File.To.Run do
  def call(file, cwd) do

    cwd = Path.join(cwd, "/")
    base = String.length(cwd)
    test_file = String.slice(file, base, String.length(file) - base)

    parts = Path.split(test_file)

    parts = List.delete(parts, List.first(parts))
    parts = List.delete(parts, List.last(parts))

    integration_test_file = get_file(parts)
    Path.join(cwd, integration_test_file)
  end

  defp get_file(["test"]) do
    "test/app_test.exs"
  end

  defp get_file(parts) do
    n = length(parts)
    candidate_name = Enum.at(parts, n - 1)
    Path.join(Path.join(parts), "#{candidate_name}_test.exs")
  end
end

