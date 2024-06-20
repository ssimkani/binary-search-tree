# frozen_string_literal: true

require_relative 'node'

# Class that represents the binary search tree
class Tree
  attr_accessor :root, :arr

  def initialize(arr)
    @arr = arr
    @root = build_tree(arr)
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

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.value}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

  def insert(value, root = @root)
    if root.nil?
      @root = value.to_node
    elsif value < root.value
      root.left.nil? ? root.left = value.to_node : insert(value, root.left)
    else
      root.right.nil? ? root.right = value.to_node : insert(value, root.right)
    end
  end
end

tree = Tree.new([15, 6, 18, 3, 7, 17, 20, 2, 4, 13, 9])

tree.build_tree(tree.arr)

tree.pretty_print
