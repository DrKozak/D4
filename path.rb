require 'set'
require_relative 'graph.rb'

# Creates a directed graph using the input file given
def read_file(filename, graph)
  File.foreach(filename) do |x|
    id, data, neighbors = vertex_creation(x)
    graph.add_vertex(id, data, neighbors)
  end
  graph
end

# Addition to string to get all permutations of words
class String
  def all_permutations
    chars.to_a.permutation.map(&:join)
  end
end

# Takes data and turns into vertex
def vertex_creation(line)
  x = line.chomp("\n").split(';')
  id = x[0].to_i
  data = x[1]
  if x[2]
    neighbors = x[2].split(',')
    neighbors = neighbors.map(&:to_i)
  else
    neighbors = []
  end
  [id, data, neighbors]
end

# Create array with permutations of all paths on graph
def permutations(paths)
  permutations = paths.map(&:downcase).map(&:all_permutations)
  permutations = permutations.flatten.sort_by(&:length).reverse
  permutations
end

# Returns an array representation of the wordlist
def wordlist(filename)
  wordlist = []
  File.foreach(filename) { |x| wordlist << x.delete!("\r\n") }
  wordlist
end

# Returns an array of all words that are in both permutations and wordlist
def real_words(permutations, wordlist)
  validwords = []
  wordlist = wordlist.to_set
  permutations.each { |x| validwords << x if wordlist.include?(x) }
  validwords
end

# Returns all words of the longest length in validwords
def longest_words(validwords, longest)
  longest_words = []
  validwords.each { |word| longest_words << word if word.length == longest }
  longest_words
end

# Returns the length of the longest word in an array
def longest_length(validwords)
  validwords = validwords.sort_by(&:length).reverse
  validwords[0].length
end

# Find longest words in wordlist
def get_words(filename)
  graph = Graph.new
  graph = read_file(filename, graph)
  paths = graph.paths
  permutations = permutations(paths)
  wordlist = wordlist('wordlist.txt')
  validwords = real_words(permutations, wordlist)
  puts "\nLongest valid word(s): from dictionary"
  longest_words(validwords, longest_length(validwords))
end
