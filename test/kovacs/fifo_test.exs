defmodule Kovacs.Fifo.Test do
  use ExUnit.Case

  test "it can be created" do
    assert [] == Kovacs.Fifo.new
  end

  test "it can have items added" do
    fifo = Kovacs.Fifo.new

    fifo = Kovacs.Fifo.add(fifo, {:ok, "item"})

    assert [{:ok, "item"}] == fifo
  end

  test "it can have multiple items added" do
    fifo = Kovacs.Fifo.new

    fifo = Kovacs.Fifo.add(fifo, {:ok, "item1"})
    fifo = Kovacs.Fifo.add(fifo, {:ok, "item2"})

    assert [{:ok, "item2"}, {:ok, "item1"}] == fifo
  end

  test "it will not add the same item twice" do
    fifo = Kovacs.Fifo.new

    fifo = Kovacs.Fifo.add(fifo, {:ok, "item1"})
    fifo = Kovacs.Fifo.add(fifo, {:ok, "item1"})

    assert [{:ok, "item1"}] == fifo
  end

  test "it will return the item" do
    fifo = Kovacs.Fifo.new

    fifo = Kovacs.Fifo.add(fifo, {:ok, "item"})
    {item, _fifo} = Kovacs.Fifo.next(fifo)

    assert {:ok, "item"} == item
  end

  test "it will remove the item" do
    fifo = Kovacs.Fifo.new

    fifo = Kovacs.Fifo.add(fifo, {:ok, "item"})
    {_item, fifo} = Kovacs.Fifo.next(fifo)

    assert [] == fifo
  end
end