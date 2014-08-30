defmodule Kovacs.Get.File.To.Run do

  def call(file) do
   case file =~ ~r/_test.exs/ do
      true ->
        file
      _ ->
        file_base = Regex.run(~r/[^(lib)][^\.]+/, file)
        "test#{file_base}_test.exs"
    end
  end
end