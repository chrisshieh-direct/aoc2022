require 'set'

class Graph
  attr_accessor :node_graph

  def initialize
    @node_graph = []
  end

  def import_graph
    File.readlines('aocdata.txt').each do |line|
        letters = line.chomp.chars
        line_of_nodes = []
        letters.each do |let|
          line_of_nodes << Node.new(let)
        end
        node_graph << line_of_nodes
    end
  end

  def populate_neighbors
    node_graph.each_with_index do |line, idx|
      line.each_with_index do |let, lidx|
        potential_neighbors = []
        potential_neighbors << line[lidx + 1] unless lidx == line.length - 1
        potential_neighbors << line[lidx - 1] unless lidx == 0
        potential_neighbors << node_graph[idx + 1][lidx] unless idx == node_graph.length - 1
        potential_neighbors << node_graph[idx - 1][lidx] unless idx == 0
        potential_neighbors.each do |neighbor|
          let.neighbors << neighbor if valid_neighbor?(let.value, neighbor.value)
        end
      end
    end
  end

  def valid_neighbor?(let, neighbor)
    validity = false
    validity = true if let == 'E' && neighbor == 'z'
    validity = true if let == 'z' && (neighbor == 'E' || neighbor == 'y')
    validity = true if let == 'a' && neighbor == 'S'
    validity = true if let.ord <= neighbor.ord
    validity = true if let.ord - 1 == neighbor.ord

    validity
  end

  def node_graph_display
    node_graph.each do |line|
      line_display = ''
      line.each do |let|
        line_display << let.value
      end
      p line_display
    end
  end

  def show_all_neighbors
    node_graph.each do |line|
      line.each do |let|
        let.show_neighbors
      end
    end
  end
end

class Node
  attr_accessor :value, :neighbors

  def initialize(value)
    @value = value
    @neighbors = []
  end

  def give_neighbors
    @neighbors
  end

  def show_neighbors
    puts "#{value}: #{neighbors.map { |x| x.value }}"
  end
end

class Queue
  def initialize
    @queue = []
  end

  def enqueue(item)
    @queue.push(item)
  end

  def dequeue
    @queue.shift
  end

  def empty?
    @queue.empty?
  end
end

def find_root(graph)
  graph.node_graph.flatten.select { |x| x.value == 'E' }.first
end

def find_target(graph)
  graph.node_graph.flatten.select { |x| x.value == 'E' }.first
end

def b_f_search(root, target, steps = 0)
  queue = Queue.new
  queue.enqueue([root, steps])

  visited = Set.new

  until queue.empty?
    node, steps = queue.dequeue
    p "#{node.value} #{steps} neighbors: "
    next if visited.include?(node)
    # return steps if node == target
    return steps if node.value == 'a'
    visited.add(node)
    node.neighbors.each do |neighbor|
      p neighbor.value
      queue.enqueue([neighbor, steps + 1])
    end
  end
  -1
end


bob = Graph.new
bob.import_graph
bob.populate_neighbors
bob.node_graph_display
root_node = find_root(bob)
target_node = find_target(bob)

puts b_f_search(root_node, target_node)

