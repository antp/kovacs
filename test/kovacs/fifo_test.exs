defmodule Kovacs.Fifo.Test do
  use ExUnit.Case

  test "it can be created" do
    assert [] == Kovacs.Fifo.new
  end

  test "it can have items added" do
    fifo = Kovacs.Fifo.new

    fifo = Kovacs.Fifo.add(fifo, "item")

    assert ["item"] == fifo
  end

  test "it can have multiple items added" do
    fifo = Kovacs.Fifo.new

    fifo = Kovacs.Fifo.add(fifo, "item1")
    fifo = Kovacs.Fifo.add(fifo, "item2")

    assert ["item2", "item1"] == fifo
  end

  test "it will return the item" do
    fifo = Kovacs.Fifo.new

    fifo = Kovacs.Fifo.add(fifo, "item")
    {item, _fifo} = Kovacs.Fifo.next(fifo)

    assert "item" == item
  end

  test "it will remove the item" do
    fifo = Kovacs.Fifo.new

    fifo = Kovacs.Fifo.add(fifo, "item")
    {_item, fifo} = Kovacs.Fifo.next(fifo)

    assert [] == fifo
  end
end