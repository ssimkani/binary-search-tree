# frozen_string_literal: true

require_relative 'node'

# Class that represents the binary search tree
class Tree
  attr_accessor :root, :arr

  def initialize(arr)
    @arr = arr
    @root = nil
  end

  def build_tree(array)
    return if array.empty?

    array = array.sort.uniq
    mid_index = ((array.length - 1) / 2).to_i
    root = Node.new(array[mid_index])

    root.left = build_tree(array[0...mid_index])
    root.right = build_tree(array[(mid_index + 1)..])

    root
  end
end
