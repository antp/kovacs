defmodule Kovacs.Get.Integration.File.To.Run do
  def call(file) do
    parts = Path.split(file)
    parts = List.delete(parts, List.first(parts))
    parts = List.delete(parts, List.last(parts))

    file = get_file(length(parts), parts)
    Path.join("test", file)
  end

  defp get_file(0, parts) do
    "app_test.exs"
  end

  defp get_file(1, parts) do
    candidate_name = List.first(parts)
    Path.join(candidate_name, "#{candidate_name}_test.exs")
  end

  defp get_file(n, parts) do
    candidate_name = Enum.at(parts, n - 1)
    Path.join(Path.join(parts), "#{candidate_name}_test.exs")
  end
end

