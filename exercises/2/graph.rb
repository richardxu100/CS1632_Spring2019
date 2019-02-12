require_relative './node.rb'

# Graph class
class Graph
  def initialize
    @nodes = {}
  end

  def num_nodes
    @nodes.keys.count
  end

  def node?(id)
    @nodes.key?(id)
  end

  def add_node(node)
    id = node.id
    @nodes[id] = node
    id
  end

  def pseudograph?
    @nodes.values.any?(&:links_to_self?)
  end

  def print
    if @nodes.keys.count.zero?
      puts 'Empty graph!'
    else
      @nodes.each do |_, vertex|
        puts vertex
      end
    end
  end
end
