# -*- ruby -*-

require 'rubygems'
require 'hoe'
require './lib/gitwiki.rb'

Hoe.new('gitwiki', GitWiki::VERSION) do |p|
  p.rubyforge_name = 'gitwiki'
  p.developer('Jared Grippe', 'gitwiki@jaredgrippe.com')
  p.extra_deps << ['mojombo-grit']
end

desc "Open an irb session preloaded with this library"
task :console do
  sh "irb -rubygems -r ./lib/gitwiki.rb"
end

# vim: syntax=Ruby
