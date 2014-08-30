defmodule Kovacs.Fifo do
  def new do
    []
  end

  def add(fifo, item) do
    {_, file} = item

    existing =  Enum.any?(fifo, fn(x) ->
      {_, coll_file} = x

      if file == coll_file do
        true
      else
        false
      end
    end)

    case existing do
      true ->
        fifo
      false ->
        [item | fifo]
    end
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