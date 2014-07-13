defmodule Kovacs.Watcher.Data do
  def new do
    [port: nil, pid: nil, path: "", files: []]
  end

  def create(port, pid, path, files) do
    [port: port, pid: pid, path: path, files: files]
  end

  def port([port: port, pid: _pid, path: _path, files: _files]) do
    port
  end

  def pid([port: _port, pid: pid, path: _path, files: _files]) do
    pid
  end

  def path([port: _port, pid: _pid, path: path, files: _files]) do
    path
  end

  def files([port: _port, pid: _pid, path: _path, files: files]) do
    files
  end

  def update_files(data, files) do
    [port: port, pid: pid, path: path, files: _old_files] = data

    [port: port, pid: pid, path: path, files: files]
  end
end