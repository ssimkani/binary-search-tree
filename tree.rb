# frozen_string_literal: true

require_relative 'node'

require 'pry-byebug'

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
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

  def insert(data, root = @root)
    if root.nil?
      @root = data.to_node
    elsif data < root.data
      root.left.nil? ? root.left = data.to_node : insert(data, root.left)
    else
      root.right.nil? ? root.right = data.to_node : insert(data, root.right)
    end
  end

  def delete(data, root = @root)
    if root.nil?
      return
    elsif data < root.data
      root.left = delete(data, root.left)
    elsif data > root.data
      root.right = delete(data, root.right)
    elsif root.left.nil? && root.right.nil?
      return nil

    elsif root.left.nil?
      return root.right

    elsif root.right.nil?
      return root.left

    elsif root.left && root.right
      temp = find_min(root.right)
      root.data = temp.data
      root.right = delete(temp.data, root.right)
    end

    root
  end

  def find_min(root)
    root.left.nil? ? root : find_min(root.left)
  end

  def find(data, root = @root)
    return if root.nil?

    if data < root.data
      find(data, root.left)
    elsif data > root.data
      find(data, root.right)
    else
      root
    end
  end

  def level_order
    return if root.nil?

    queue = [root]
    arr = []
    until queue.empty?
      node = queue.shift
      if block_given?
        yield node
      else
        arr << node.data
      end
      queue << node.left if node.left

      queue << node.right if node.right
    end
    arr
  end

  def preorder(node = @root, arr = [], &block)
    return if node.nil?

    if block_given?
      yield node
    else
      arr << node.data
    end
    preorder(node.left, arr, &block)
    preorder(node.right, arr, &block)
    arr
  end
end

tree = Tree.new([15, 6, 18, 3, 7, 17, 20, 2, 4, 13, 9])

tree.build_tree(tree.arr)
tree.pretty_print

p tree.preorder
