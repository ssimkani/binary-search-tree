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

  # Builds a balanced binary search tree
  def build_tree(array)
    return if array.empty?

    array = array.sort.uniq
    mid_index = ((array.length - 1) / 2).to_i
    root = Node.new(array[mid_index])

    root.left = build_tree(array[0...mid_index])
    root.right = build_tree(array[(mid_index + 1)..])

    root
  end

  # Prints out tree
  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

  # Inserts a node as a leaf
  def insert(data, root = @root)
    if root.nil?
      @root = data.to_node
    elsif data < root.data
      root.left.nil? ? root.left = data.to_node : insert(data, root.left)
    else
      root.right.nil? ? root.right = data.to_node : insert(data, root.right)
    end
  end

  # Deletes a node from the tree
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

  # Finds the minimum value to be used in the delete method
  def find_min(root)
    root.left.nil? ? root : find_min(root.left)
  end

  # Finds the node with a given value
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

  # Traverses the tree in level order
  def level_order(&block)
    return if root.nil?

    queue = [root]
    arr = []
    until queue.empty?
      node = queue.shift
      process(node, arr, &block)
      queue << node.left if node.left

      queue << node.right if node.right
    end
    arr
  end

  # Traverses the tree in preorder, inorder, and postorder
  def preorder(node = @root, arr = [], &block)
    return if node.nil?

    process(node, arr, &block)
    preorder(node.left, arr, &block)
    preorder(node.right, arr, &block)
    arr
  end

  def inorder(node = @root, arr = [], &block)
    return if node.nil?

    inorder(node.left, arr, &block)
    process(node, arr, &block)
    inorder(node.right, arr, &block)
    arr
  end

  def postorder(node = @root, arr = [], &block)
    return if node.nil?

    postorder(node.left, arr, &block)
    postorder(node.right, arr, &block)
    process(node, arr, &block)
    arr
  end

  # Helper method for processing a node
  def process(node, arr)
    if block_given?
      yield node
    else
      arr << node.data
    end
  end

  # Finds the height of the tree
  def height(node)
    node = find(node) if node.is_a?(Integer)
    return -1 if node.nil?

    left_height = height(node.left)
    right_height = height(node.right)

    left_height > right_height ? left_height + 1 : right_height + 1
  end

  # Finds the depth of a given node
  def depth(node, root = @root, depth = 0)
    return if node.nil?

    depth += 1
    if node < root.data
      depth(node, root.left, depth)
    elsif node > root.data
      depth(node, root.right, depth)
    else
      depth - 1
    end
  end

  # Checks if tree is balanced
  def balanced?(root = @root)
    return true if root.nil?

    left_height = height(root.left)
    right_height = height(root.right)

    (left_height - right_height).abs <= 1 && balanced?(root.left) && balanced?(root.right)
  end

  # Rebalances tree
  def rebalance
    @root = build_tree(level_order)
  end
end
