require 'flamegraph'
require_relative 'graph.rb'
require_relative 'path.rb'

Flamegraph.generate('flamegrapher.html') do
  get_words(ARGV[0])
end
