defmodule Kovacs.Cfg do

  def configure do
    Kovacs.watch("lib")
    Kovacs.watch("test")
  end
end