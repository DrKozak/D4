require 'simplecov'
SimpleCov.start
require 'minitest/autorun'
require_relative 'graph.rb'

# Test Suite for finder
class GraphTest < Minitest::Test
  def setup
    @g = Graph.new
    @v = Vertex.new(1, 'D', [3, 5])
  end

  def test_add_vertex
    @g.add_vertex(1, 'D', [3, 5])
    vertex = @g.vertices[0]
    assert_equal(@v.id, vertex.id)
    assert_equal(@v.data, vertex.data)
    assert_equal(@v.neighbors, vertex.neighbors)
  end

  def test_find_vert
    @g.add_vertex(5, 'Q', [])
    vertex = @g.find_vert(5)
    assert_equal(5, vertex.id)
  end

  def test_find_vert_identification
    assert_nil(@g.find_vert(0))
  end

  def test_ends
    @g.add_vertex(2, 'A', [5, 6])
    @g.add_vertex(5, 'D', [])
    @g.add_vertex(6, 'B', [])
    expected = [5, 6]
    ends = []
    end_vertices = @g.ends
    end_vertices.each { |e| ends << e.id }
    assert_equal(expected.sort, ends.sort)
  end

  def test_edges
    @g.add_vertex(1, 'C', [2])
    @g.add_vertex(2, 'A', [5, 6])
    @g.add_vertex(5, 'Q', [])
    @g.add_vertex(6, 'B', [])
    expected = [[1, 2], [2, 5], [2, 6]]
    assert_equal(expected.sort, @g.edges.sort)
  end

  def test_vertex_edges
    @g.add_vertex(1, 'C', [2])
    @g.add_vertex(2, 'A', [5, 6])
    @g.add_vertex(5, 'D', [])
    @g.add_vertex(6, 'B', [])
    expected = [[2, 6], [2, 5]]
    assert_equal(expected.sort, @g.vertex_edges(2).sort)
  end

  def test_path_true
    @g.add_vertex(1, 'C', [2])
    @g.add_vertex(2, 'A', [5, 6])
    @g.add_vertex(5, 'D', [])
    @g.add_vertex(6, 'B', [])
    actual = @g.path?(1, 2)

    assert_equal(true, actual[0])
  end

  def test_path_false
    @g.add_vertex(1, 'C', [2])
    @g.add_vertex(2, 'A', [5, 6])
    @g.add_vertex(5, 'D', [])
    @g.add_vertex(6, 'B', [])
    actual = @g.path?(6, 1)

    assert_equal(false, actual)
  end

  def test_paths
    @g.add_vertex(1, 'C', [2])
    @g.add_vertex(2, 'A', [5, 6])
    @g.add_vertex(5, 'D', [])
    @g.add_vertex(6, 'B', [])
    expected = %w[DAC BAC DA BA D B]
    assert_equal(expected.sort, @g.paths.sort)
  end
end
