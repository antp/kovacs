# Kovacs - A simple ExUnit test runner

## Installation

Download the latest release (or clone) the repository and build Kovacs with:

    MIX_ENV=prod mix escript.build


Install the application into a directory on your path

        /usr/local/bin

The easiest way to do this is to create a symbolic link to kovacs in
the directory where you have downloaded the project too.

        ln -s ~/{project path}/kovacs /usr/local/bin/kovacs

## Dependencies

You will also need fswatch installed as Kovacs uses this to monitor the file system.
Please download fswatch for your OS from its [github repository](https://github.com/emcrisostomo/fswatch).


## Quick start

kovacs can then be run in any directory by typing the following:

        kovacs

By default it will monitor the __lib__ and __test__ directories.

Due to problems closing down external applications when exiting Elixir command line applications,
please enter `q<cr>` to quit Kovacs.

__Important:__ Failure to do this will leave instances of fswatch running on your system and you will need to manually tidy them up.

When you save a file, Kovacs will run the corresponding test file.
The runner will look for a test file in the same directory structure as the tested file.

If you have a file in:

        lib/parser/filter.ex

then it will expect the test file:

        test/parser/filter_test.exs

When running Kovacs, the colour output from ExUnit will not be shown. If you want to have colour output then update the projects test_helper.ex file to the following:

        ExUnit.start([colors: [enabled: true]])

Kovacs will exclude any tests that are tagged with `@pending` or `@ignore`.

        @tag :pending
        test "It will add" do
            assert 2 == 1 + 1
        end

## Integration tests

If a all tests pass for the last run file, Kovacs will attempt to run a file named after the directory the test file is in. This allows for targeted integration tests for all files that collaborate within a directory.

If it is the root directory then Kovacs will look for a file named `app_test.exs`.

You can toggle the running of the integration test file at any time by entering `i<cr>`.

## Configuration

if you want to watch any custom directories then you will need to supply a configuration file.

Create a Elixir configuration file e.g. kovacs.ex
with the following contents.

        defmodule Kovacs.Cfg do
          def configure do
            Kovacs.watch(["./lib/dir1", "./lib/dir2", "./test"])
          end
        end

This will watch the __lib/dir1__, __lib/dir2__ and __test__ directories from your project root,
for file changes.


__Note:__ Do not watch sub directories of an already watched directory.
Duplicate file changes may be detected if you do.

### Running

Run kovacs with the following

        kovacs {optional configuration file}



__Important:__ When exiting the application press the `q` key followed by carriage return.
Do not exit kovacs with `ctrl-c`. This will leave fswatch instances running,
which you will need to manually clean up -- you have been warned.

## Author

Copyright © 2014 Component X Software, Antony Pinchbeck

Released under Apache 2 License

