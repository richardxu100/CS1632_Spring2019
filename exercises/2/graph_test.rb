# Note that we require and start simplecov before
# doing ANYTHING else, including other require statements.
require 'simplecov'
SimpleCov.start

# Previous code starts here!
require 'minitest/autorun'
require_relative 'graph'

# Tests for Graph class
class GraphTest < Minitest::Test
  # Special method!
  # This will run the following code before each test
  # We will re-use the @g instance variable in each method
  # This was we don't have to type g = Graph::new in each test

  def setup
    @graph = Graph.new
  end

  # Remember tests must start with test_ !

  # A very simple test to get you into the swing of things!
  # Creates a graph, refutes that it's nil, and asserts that it is a
  # kind of Graph object.

  def test_new_graph_not_nil
    refute_nil(@graph)
    assert_kind_of(Graph, @graph)
  end

  # This is a "regular" add node test.
  # We are checking to see if we add a node, does the graph report
  # the correct number of nodes.
  # Note though that we now have a dependency on the Node class now,
  # even though we are testing

  def test_add_node
    node = Node.new(1, [2, 3])
    @graph.add_node(node)
    assert_equal(@graph.num_nodes, 1)
  end

  # Create a node which is not part of the graph and refute (opposite
  # of assert) that it is in the graph.  That is, if we do not add
  # to the graph, it should not be in there
  def test_has_node_dummy_with_obj
    nonexistent_node = Node.new(1, [2])
    refute @graph.node?(nonexistent_node)
  end

  # Verify that adding one node makes our count one.

  def test_add_node_double
    node = Node.new(1, [1])
    @graph.add_node(node)
    # Assert
    assert_equal(1, @graph.num_nodes)
  end

  # Verify that an empty node prints out "Empty graph!" when
  # print method is called.

  def test_print_empty
    assert_output("Empty graph!\n") { @graph.print }
  end

  def test_print_has_nodes
    correct_output = ['Node 1: [ 2,3 ]', 'Node 2: [ 2,3 ]']
    node1 = Node.new(1, [2, 3])
    node2 = Node.new(2, [2, 3])
    @graph.add_node(node1)
    @graph.add_node(node2)
    assert_output(correct_output.join("\n") + "\n") { @graph.print }
  end

  def test_pseudograph_success
    node1 = Node.new(1, [2, 3])
    node2 = Node.new(2, [2, 3])
    @graph.add_node(node1)
    @graph.add_node(node2)
    assert(@graph.pseudograph?)
  end

  def test_pseudograph_failure
    node1 = Node.new(1, [2, 3])
    node2 = Node.new(2, [3, 4])
    @graph.add_node(node1)
    @graph.add_node(node2)
    refute(@graph.pseudograph?)
  end
end
