# Class for board squares
class Node
    attr_accessor :value, :parent, :child

    def initialize(value=nil, parent=nil)
        @value = value
        @parent = parent
        @child = nil
    end
end # End of class Node

# Class for Chess Board
class Board
    attr_reader :board

    def initialize(board_size)
        # Make a NxN board of size board_size
        @board = fill_board(board_size)
    end

    # Method to initialize the board
    def fill_board(size)
        board = []
        board_rows = []
        size.times {|i| board_rows << i}
        size.times {board << board_rows}
        @board = board
    end

    # Checking if the position passed is in play
    def valid_play(x, y)
        temp = @board.length - 1
        x.between?(0,temp) && y.between?(0,temp) ? true : false
    end

end # End of class Board

# Class for Knight Piece, which inherits methods from the Board class
class Knight < Board
    def initialize(board_size)
        super(board_size)
        @piece = "Knight"
        # All available moves for a knight
        @move_rows = [2, 2, -2, -2, 1, 1, -1, -1]
        @move_cols = [-1, 1, 1, -1, 2, -2, 2, -2]
    end

    # Method for building out tree with nodes of possible moves from the knight
    # Takes in a Node object and the visited array to check for duplicates
    def build_path(parent_pos, visited)
        possible_moves = []
        # Getting all available moves for knight and applying it to the current position (root)
        @move_rows.each_with_index do |value, index|
            temp_arr = [parent_pos.value[0] + @move_rows[index], parent_pos.value[1] + @move_cols[index]] # Temp variable for repetition
            # Checking for validity of the new moves as well as checking if it hasn't already been visited
            if valid_play(parent_pos.value[0] + @move_rows[index], parent_pos.value[1] + @move_cols[index]) && !visited.include?(temp_arr)
                possible_moves << [parent_pos.value[0] + @move_rows[index], parent_pos.value[1] + @move_cols[index]]
            end
        end
        # Get all possible moves and add it as a child to the parent Node that was passed
        possible_moves.map do |value|
            parent_pos.child = Node.new(value, parent_pos)
        end
    end

    # Method for printing all of the moves taken by taking the end Node and getting all the parents
    # Takes in a Node (destination position)
    def print_path(node)
        print_arr = [node.value]
        while !node.parent.nil?
            print_arr << node.parent.value
            node = node.parent
        end
        print_arr.reverse!
        puts "You reached your destination in #{print_arr.length - 1} moves! Here was your path:"
        print_arr.each {|value| puts "\t#{value}"}
    end

    # Method for moving the knights and checking if destination is reach
    def knight_moves(start, dest)
        return puts "You are already there." if start == dest # If user input same starting and destination
        return puts "Starting position is invalid" if !valid_play(start[0], start[1]) # If user input invalid starting position
        return puts "Destination is invalid" if !valid_play(dest[0], dest[1]) # If user input invalid position on the board as destination

        visited = [start] # Start the visited array with start position as that has been checked for above (if start == dest)
        queue = []
        
        queue = build_path(Node.new(start), visited) # Returns the first iteration of the possible moves for the knight piece
        while !queue.empty? # Run until all positions have been checked
            current = queue.shift()
            if current.value == dest # If found
                print_path(current)
                break
            else
                visited << current.value # Mark position checked for
                queue += build_path(current, visited) # Add on new possible positions the knight can take
            end
        end
    end # End of knight_moves

end # End of class Knight

knight = Knight.new(8)
knight.knight_moves([3,3], [4,3]) # => "You have reached your destination in 3 moves! Here was your path"
                                  #     [3,3]
                                  #     [5,2]
                                  #     [3,1]
                                  #     [4,3]
puts ""
knight.knight_moves([4,5], [1,1]) # => "You have reached your destination in 3 moves! Here was your path"
                                  #     [4,5]
                                  #     [2,4]
                                  #     [0,3]
                                  #     [1,1]
puts ""
knight.knight_moves([8,9], [1,2]) # => "Starting position is invalid"
puts ""
knight.knight_moves([0,5], [12,6]) # => "Destination is invalid"