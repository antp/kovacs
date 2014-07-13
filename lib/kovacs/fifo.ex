defmodule Kovacs.Fifo do
  def new do
    []
  end

  def add(fifo, item) do
    [item | fifo]
  end

  def has_items?(fifo) do
    0 != length(fifo)
  end

  def next(fifo) do
    item = List.last(fifo)
    fifo = List.delete_at(fifo, length(fifo) - 1)

    {item, fifo}
  end

end