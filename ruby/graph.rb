require 'set'

class Graph
  attr_accessor :graph
  def initialize(paths)
    @graph = Hash.new
    if ! paths.empty?
      paths.each {|path|
        if path.length == 1 && @graph.empty?
          @graph[path[0]] = Set[]
        else
          path.each_with_index {|var, idx| 
            @graph[var] = Set[] if !@graph.has_key? var
            set = @graph[var]
            if idx == 0
              set.add(path[idx+1])
            elsif idx == (path.length - 1)
              set.add(path[idx-1])
            else 
              set.merge([path[idx-1],path[idx+1]])
            end
          }
        end
      }
    end
  end

  def is_adjacent(vertex_a, vertex_b)
    return @graph[vertex_a].include? vertex_b
  end

  # array is an adjacency list
  def add_vertex(vertex, array)
    @graph[vertex] = Set[] unless @graph.has_key? vertex

    @graph[vertex].merge(array)
    array.each {|vert| 
      if @graph.has_key? vert
        @graph[vert].add(vertex)
      else
        @graph[vert] = Set[vertex]
      end
      }
  end
end

if __FILE__ == $PROGRAM_NAME
  x = Graph.new([])
  puts x.graph
  x = Graph.new([1])
  puts x.graph
  # puts "Expecting: {}"
  # puts graph.graph

  # puts

  # graph = Graph.new([["a", "b", "c"], ["b", "d"]])
  # puts graph.is_adjacent('a','b')
  # puts graph.is_adjacent('a','d')
  # graph.add_vertex('a',['c','d','e'])

  # puts 'Expecting: { a: { "b" }, b: { "a", "c", "d" }, c: { "b" }, d: { "b" }}'
  # puts graph.graph

  # puts

  # # Don't forget to add your own!

  # puts "Expecting: true"
  # puts graph.is_adjacent("a", "b")

  # puts

  # puts "Expecting: false"
  # puts graph.is_adjacent("a", "c")

  # puts

  # graph.add_vertex("e", ["a", "d"])
  # puts 'Expecting: { a: { "b", "e" }, b: { "a", "c", "d" }, c: { "b" }, d: { "b", "e" }, e: { "a", "d" } }'
  # puts graph.graph
end

# Please add your pseudocode to this file
# And a written explanation of your solution
