# frozen_string_literal: true

require_relative 'lib/tree'

# Driver Script

# Create a binary search tree from an array of random numbers
arr = (Array.new(15) { rand(1..100) })
tree = Tree.new(arr)

# Confirm that the tree is balanced
puts tree.balanced?

# Print out all elements in level, pre, post, and in order
tree.level_order { |node| puts node.data }
print "\n"
tree.preorder { |node| puts node.data }
print "\n"
tree.postorder { |node| puts node.data }
print "\n"
tree.inorder { |node| puts node.data }
print "\n"

# Unbalance the tree by adding several numbers > 100
tree.insert(145)
tree.insert(1345)
tree.insert(144)
tree.insert(304)
tree.insert(605)
tree.insert(106)

# Confirm that the tree is unbalanced
puts tree.balanced?

# Balance the tree
tree.rebalance

# Confirm that the tree is balanced
puts tree.balanced?

# Print out all elements in level, pre, post, and in order
tree.level_order { |node| puts node.data }
print "\n"
tree.preorder { |node| puts node.data }
print "\n"
tree.postorder { |node| puts node.data }
print "\n"
tree.inorder { |node| puts node.data }
print "\n"
