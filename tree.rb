# frozen_string_literal: true

# Class that represents the binary search tree
class Tree
  attr_accessor :root

  def initialize(arr)
    @arr = arr
    @root = nil
  end
end
