defmodule Kovacs.Watcher.Data do
  def new do
    [port: nil, pid: nil, path: ""]
  end

  def create(port, pid, path) do
    [port: port, pid: pid, path: path]
  end

  def port([port: port, pid: _pid, path: _path]) do
    port
  end

  def pid([port: _port, pid: pid, path: _path]) do
    pid
  end

  def path([port: _port, pid: _pid, path: path]) do
    path
  end
end