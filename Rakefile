# -*- ruby -*-

require 'rubygems'
require 'hoe'
require './lib/git_wiki.rb'

Hoe.new('git_wiki', GitWiki::VERSION) do |p|
  p.rubyforge_name = 'git_wiki'
  p.developer('Jared Grippe', 'gitwiki@jaredgrippe.com')
  p.extra_deps << ['mojombo-grit']
end

desc "Open an irb session preloaded with this library"
task :console do
  sh "irb -rubygems -r ./lib/git_wiki.rb"
end

# vim: syntax=Ruby
