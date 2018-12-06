require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require_relative 'path.rb'

# Test Suite
class PathTest < Minitest::Test
  # Graph class and accessor vertices
  class Graph
    attr_accessor :vertices

    def initialize
      @vertices = []
    end

    def add_vertex(id, data, neighbors)
      @vertices << [id, data, neighbors]
    end
  end

  def mock_file(filename, text)
    File.open filename, 'w' do |file|
      file.write(text)
    end
  end

  def test_permutations
    paths = %w[ab cd]
    expected = %w[ba dc ab cd]
    assert_equal(permutations(paths).sort, expected.sort)
  end

  def test_word_list
    permutations = %w[act atc cat cta tac tca]
    wordlist = %w[cat act bat]
    expected = %w[cat act]
    assert_equal(real_words(permutations, wordlist).sort, expected.sort)
  end

  def test_vertex_creation
    line = '0;U;0,5'
    expected = [0, 'U', [0, 5]]
    assert_equal(expected, vertex_creation(line), expected)
  end

  def test_vertex_creation_no_neighbors
    line = '11;Z;'
    expected = [11, 'Z', []]
    assert_equal(expected, vertex_creation(line), expected)
  end

  def test_long_words
    validwords = %w[lake cake bake ake ok a]
    expected = %w[lake cake bake]
    assert_equal(expected.sort, longest_words(validwords, 4).sort)
  end

  def test_long_length
    validwords = %w[flake bake make great at e]
    assert_equal(5, longest_length(validwords))
  end

  def test_wordlist
    filename = 'testfile.txt'
    mock_file(filename, "sample\r\nwordlist\r\ntext\r\n")
    expected = %w[sample wordlist text]
    assert_equal(wordlist(filename).sort, expected.sort)
  end

  def test_get_words
    filename = 'testfile.txt'
    mock_file(filename, "1;C;2, 3\r\n2;A;3, 4, 6\r\n3;K;5\r\n4;T;\r\n5;E;\r\n6;B;\r\n")
    longest_words = get_words(filename)
    assert_equal(['cake'], longest_words)
  end

  def test_read_file
    filename = 'testfile.txt'
    mock_file(filename, "1;C;2, 3\r\n2;A;3, 4, 6\r\n3;K;5\r\n4;T;\r\n")
    expected_graph = Graph.new
    expected_graph.add_vertex(1, 'C', [2, 3])
    expected_graph.add_vertex(2, 'A', [3, 4, 6])
    expected_graph.add_vertex(3, 'K', [5])
    expected_graph.add_vertex(4, 'T', [])
    assert_equal(expected_graph.vertices, read_file(filename, Graph.new).vertices)
  end
end
