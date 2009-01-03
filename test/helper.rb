require File.join(File.dirname(__FILE__), *%w[.. lib git_wiki])

require 'rubygems'
require 'test/unit'

TMP_DIR = File.join(File.dirname(__FILE__), *%w[tmp])

include Grit
