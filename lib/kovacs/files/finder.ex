defmodule Kovacs.Files.Finder do
  def get_files(path) do
    watched_files = find_files_by_ext(path, ["ex", "exs"])

    get_modified_times(watched_files)
  end

  defp find_files_by_ext(path, extensions) do
    joined_extensions = Enum.join(extensions, ",")

    Path.wildcard("#{path}/**/*.{#{joined_extensions}}")
  end

  def get_modified_times(files) when is_list(files) do
    Enum.map(files, fn(file) ->
      { file, File.stat!(file).mtime }
    end)
  end
end