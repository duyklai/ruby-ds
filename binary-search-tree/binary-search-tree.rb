class Node
    attr_accessor :value, :parent, :left_child, :right_child

    def initialize(value=nil)
        @value = value
        @parent = nil
        @left_child = nil
        @right_child = nil
    end
end # End of class Node

class BinaryTree
    attr_accessor :root

    def initialize
        @root = nil
    end

    # Method which takes an array of data and turns it into a binary tree full of Node objects
    def build_tree(arr)
        @root = Node.new(arr[0])
        for index in (1...arr.length)
            temp_root_node = @root
            new_node = Node.new(arr[index])
            while temp_root_node.left_child != nil || temp_root_node.right_child != nil
                if temp_root_node.value < new_node.value # If new value is bigger than current
                    if temp_root_node.right_child == nil
                        new_node.parent = temp_root_node
                        temp_root_node.right_child = new_node
                        break
                    else
                        temp_root_node = temp_root_node.right_child
                    end
                elsif temp_root_node.value > new_node.value # If new value is smaller than current
                    if temp_root_node.left_child == nil
                        new_node.parent = temp_root_node
                        temp_root_node.left_child = new_node
                        break
                    else
                        temp_root_node = temp_root_node.left_child
                    end
                end # End of temp_root_node.value < new_node.value
            end # End of while loop

            # In the case that the current node is a leaf node
            if temp_root_node.left_child.nil? && temp_root_node.right_child.nil?
                new_node.parent = temp_root_node
                temp_root_node.value > new_node.value ? temp_root_node.left_child = new_node : temp_root_node.right_child = new_node
            end
        end # End of for loop

    end # End of method build_tree(arr)

    # Takes a target value and returns the node at which it is located using the breadth first search technique
    # Return nil if not found
    def breadth_first_search(value)
        return nil if @root.nil? # No tree

        queue = [@root] # Start queue with root node
        while !queue.empty?
            return queue.first if queue.first.value == value
            queue << queue.first.left_child if queue.first.left_child # Add left child
            queue << queue.first.right_child if queue.first.right_child # Add right child
            queue.shift # Remove the first element since queues are (FIFO)
        end
        return nil # If value was not found
    end

    # Returns the node at which the target value is located using the depth first search technique using a stack
    # Return nil if not found
    def depth_first_search(value)
        return nil if @root.nil? # No tree

        current = @root
        stack = []

        loop do # Loop until stack is empty
            if !current.nil? # If current node is not nil
                stack.push(current) # Add it and continue down the left subtree
                current = current.left_child # Left subtree
            else
                if stack.empty? # Keeping loop from running infinitely
                    break
                else
                    current = stack.pop # If current node is nil (reached one below leaf node), pop the latest stack value
                    if current.value == value
                        return current
                    end
                    current = current.right_child # If value is not correct, check for right_child or right subtree
                end
            end
        end

        return nil # If value was not found
    end

    # Returns the node at which the target value is located but instead of using a stack, uses recursive method
    # Return nil if not found
    def dfs_rec(value)
        dfs_rec_helper(@root, value)
    end

    # Helper method for depth_first_search recursion as the testing code does not have access to @root
    def dfs_rec_helper(node, value)
        left = dfs_rec_helper(node.left_child, value) if node.left_child
        return node if node.value == value
        right = dfs_rec_helper(node.right_child, value) if node.right_child
        
        return left if left
        return right if right

        return nil
    end

    # Method for printing the tree in 2D
    def print_tree
        space = 0
        print_tree_helper(@root, space)
    end

    # Helper method for print_tree
    # Modified to ruby code from https://www.geeksforgeeks.org/print-binary-tree-2-dimensions/
    def print_tree_helper(root, space)
        # Base case 
        if root == nil
            return
        end
        
        space += 7 # Increase distance between levels  
        
        print_tree_helper(root.right_child, space) if root.right_child # Process right child first, making sure there is a right child
        # Print current node after space
        puts ""
        for i in (7...space)
            print " "
        end
        print root.value

        print_tree_helper(root.left_child, space) if root.left_child # Process left child, making sure there is a left child
    end

end # End of class BinaryTree

# Testing code
my_arr = [1, 7, 4, 23, 6, 8, 19, 3, 5, 12, 9, 67, 36]

bin_tree = BinaryTree.new
bin_tree.build_tree(my_arr)
bin_tree.print_tree

puts "\n\n\n" # Spacing for tree print

temp = bin_tree.breadth_first_search(67)
# Expected => "bfs(67): 67, parent: 23, left: 36" ; Left out right child due to there being none
p "bfs(67): #{temp.value}, parent: #{temp.parent.value}, left: #{temp.left_child.value}"

temp = bin_tree.depth_first_search(4)
# Expected => "dfs(4): 4, parent: 7, left: 3, right: 6"
p "dfs(4): #{temp.value}, parent: #{temp.parent.value}, left: #{temp.left_child.value}, right: #{temp.right_child.value}"

temp = bin_tree.dfs_rec(6)
# Expected => "dfs_rec(6): 6, parent: 4, left: 5" ; Left out right child due to there being none
p "dfs_rec(6): #{temp.value}, parent: #{temp.parent.value}, left: #{temp.left_child.value}"