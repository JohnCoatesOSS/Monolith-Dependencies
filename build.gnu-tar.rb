#!/usr/bin/env ruby
# from https://github.com/Homebrew/homebrew/blob/master/Library/Formula/gnu-tar.rb
require 'pp'
require 'fileutils'
STDOUT.sync = true

currentDirectory = File.dirname(__FILE__)
gnuTarDirectory = File.join(currentDirectory, "gnu-tar-1.28")
Dir.chdir(gnuTarDirectory) do

  # Fix for xattrs bug causing build failures on OS X:
  # https://lists.gnu.org/archive/html/bug-tar/2014-08/msg00001.html
  patchURL = "https://gist.githubusercontent.com/mistydemeo/10fbae8b8441359ba86d/raw/e5c183b72036821856f9e82b46fba6185e10e8b9/gnutar-configure-xattrs.patch"
  patchFilename = File.basename(patchURL)
  if File.exists?(patchFilename) == false
    system "curl -O #{patchURL}"
    system "patch -g 0 -f -p1 -i ./gnutar-configure-xattrs.patch"
  end

    # Work around unremovable, nested dirs bug that affects lots of
    # GNU projects. See:
    # https://github.com/Homebrew/homebrew/issues/45273
    # https://github.com/Homebrew/homebrew/issues/44993
    # This is thought to be an el_capitan bug:
    # http://lists.gnu.org/archive/html/bug-tar/2015-10/msg00017.html
  ENV["gl_cv_func_getcwd_abort_bug"] = "no"
  buildDirectory = File.join(gnuTarDirectory, "build")
  if File.exists?(buildDirectory) == false
    FileUtils.mkdir(buildDirectory)
  end

  Dir.chdir(buildDirectory)
    system "../configure", "--program-prefix=g"
    system "make"
  end

end
