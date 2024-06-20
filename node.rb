# frozen_string_literal: true

# Class for the nodes of the binary search tree
class Node
  include Comparable

  attr_accessor :value, :left, :right

  def initialize(value, left = nil, right = nil)
    @value = value
    @left = left
    @right = right
  end
end

# Class that converts an integer to a node
class Integer
  def to_node
    Node.new(self)
  end
end
