defmodule Kovacs.Get.File.To.Run do

  def call(file, cwd) do
   case file =~ ~r/_test.exs/ do
      true ->
        file
      _ ->
      	cwd = Path.join(cwd, "/")
      	base = String.length(cwd)
      	changed_file = String.slice(file, base, String.length(file) - base)

        file_base = Regex.run(~r/[^(\/lib)][^\.]+/, changed_file)

        "#{cwd}/test/#{file_base}_test.exs"
    end
  end

end