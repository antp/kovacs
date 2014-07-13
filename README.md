# Kovacs - A simple ExUnit test runner

## Installation

Place the kovacs and fswatch executables in your Elixir applications root.

## Configuration

Create a Elixir configuration file e.g. kovacs.ex
with the following contents.

        defmodule Kovacs.Cfg do
          def configure do
            Kovacs.watch("lib")
            Kovacs.watch("test")
          end
        end

This will watch both the "lib" and "test" directories from your project root,
for file changes.

Add entries in the configure function to monitor any directories you require e.g.

        Kovacs.watch("apps/test/lib")

__Note:__ Do not watch sub directories of an already watched directory.
Duplicate file changes will be detected if you do.

### Running

Run kovacs with the following

        ./kovacs kovacs.ex

The runner will look for a test file in the same directory structure as the tested file.

If you have a file in:

        lib/parser/filter.ex

then it will expect a test file:

        test/parser/filter_test.ex

__Important:__ When exiting the application press the 'q' key followed by carridge return.
Do not exit kovacs with ctrl-c and aborting the VM. This will leave fswatch instancies running,
which you will need to manually clean up -- you have been warned.

## Author

Copyright © 2014 Antony Pinchbeck

Released under Apache 2 License

