defmodule Kovacs.Cfg do

  def configure do
    Kovacs.watch(["./lib", "./test"])
  end
end