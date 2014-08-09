# Kovacs - A simple ExUnit test runner

## Installation

Install the application into

        /usr/local/bin

The easest way to do this is to create a symbolic link to kovacs and fswatch files in
the directory where you have downloaded the project too.

        ln -s ~/{project path}/fswatch /usr/local/bin/fswatch
        ln -s ~/{project path}/kovacs /usr/local/bin/kovacs

You may not need to link fswatch if you have already installed it.

kovacs can then be run in any directory by typing the following:

        kovacs {config file}

## Configuration

If kovacs is run without a configuration file it will by default watch
the __lib__ and __test__ directories.

if you want to watch any custom directories then you will need to supply a confiuration file.

Create a Elixir configuration file e.g. kovacs.ex
with the following contents.

        defmodule Kovacs.Cfg do
          def configure do
            Kovacs.watch("lib/dir1")
            Kovacs.watch("lib/dir2")
            Kovacs.watch("test")
          end
        end

This will watch the __lib/dir1__, __lib/dir2__ and __test__ directories from your project root,
for file changes.

Add entries in the configure function to monitor any directories you require e.g.

        Kovacs.watch("apps/test/lib")

__Note:__ Do not watch sub directories of an already watched directory.
Duplicate file changes will be detected if you do.

### Running

Run kovacs with the following

        kovacs {optional configuration file}

The runner will look for a test file in the same directory structure as the tested file.

If you have a file in:

        lib/parser/filter.ex

then it will expect a test file:

        test/parser/filter_test.exs

__Important:__ When exiting the application press the 'q' key followed by carridge return.
Do not exit kovacs with ctrl-c and aborting the VM. This will leave fswatch instancies running,
which you will need to manually clean up -- you have been warned.

## Author

Copyright © 2014 Component X Software, Antony Pinchbeck

Released under Apache 2 License

