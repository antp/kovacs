# Kovacs - A simple ExUnit test runner

## Installation

Install the application into a directory on your path

        /usr/local/bin

The easiest way to do this is to create a symbolic link to kovacs in
the directory where you have downloaded the project too.

        ln -s ~/{project path}/kovacs /usr/local/bin/kovacs

## Dependancies

You will also need fswatch installed as Kovacs uses this to monitor the file system.
You can install fswatch for your os from its [github repository](https://github.com/emcrisostomo/fswatch).


## Quick start

kovacs can then be run in any directory by typing the following:

        kovacs

By default it will monitor the __lib__ and __test__ directories.

Due to problems closing down external applications when exiting Elixir command line applications,
please enter 'q \<return\>' to quit Kovacs.

__Important:__ Failure to do this will leave instances of fswatch running on your system.

When you save a file, Kovacs will run the corresponding test file.
The runner will look for a test file in the same directory structure as the tested file.

If you have a file in:

        lib/parser/filter.ex

then it will expect the test file:

        test/parser/filter_test.exs


It will also run an integration test file that has the same name as the directory containing the last test file that was run.

You can toggle the running of the integration file by entering the command 'i \<return\>'


When running Kovacs, the coloured output from ExUnit will not be shown. If you want to have coloured output
then update the projects test_helper.ex file to the following:

        ExUnit.start([colors: [enabled: true]])

## Configuration

if you want to watch any custom directories then you will need to supply a configuration file.

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



__Important:__ When exiting the application press the 'q' key followed by carriage return.
Do not exit kovacs with ctrl-c and aborting the VM. This will leave fswatch instances running,
which you will need to manually clean up -- you have been warned.

## Author

Copyright © 2014 Component X Software, Antony Pinchbeck

Released under Apache 2 License

