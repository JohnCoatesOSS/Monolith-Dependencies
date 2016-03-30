#!/usr/bin/env ruby
# from https://github.com/Homebrew/homebrew/blob/master/Library/Formula/dpkg.rb
require 'pp'
require 'fileutils'
STDOUT.sync = true

currentDirectory = File.dirname(__FILE__)
sourceDirectory = File.join(currentDirectory, "dpkg-1.18.4")
Dir.chdir(sourceDirectory) do
  buildDirectory = File.join(sourceDirectory, "build")
  if File.exists?(buildDirectory) == false
    FileUtils.mkdir(buildDirectory)
  end

  Dir.chdir(buildDirectory) do
    # system "../configure", "--disable-dependency-tracking",
    #                    "--disable-silent-rules",
    #                    "--disable-dselect",
    #                    "--disable-linker-optimisations",
    #                    "--disable-start-stop-daemon"
    system "make"
  end
end
