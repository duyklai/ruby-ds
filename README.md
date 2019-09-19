# Ruby Data Structure Implementation

My implementation of a binary search tree, with traversal/search function breadth-first-search and depth-first-search included. Print tree function is modified code from [Geeksforgeeks](https://www.geeksforgeeks.org/print-binary-tree-2-dimensions/). The rb file includes some very basic test code. This current iteration **does not** deal with repeating/same multiple of the same number in the array original array.

To run *binary-search-tree.rb* :
```
$ cd binary-search-tree
$ ruby binary-search-tree.rb
```

![alt text](https://github.com/duyklai/ruby-ds/blob/master/images/binary-tree.jpg "Sample BST Test")

Knight Moves is a program that takes a starting position and a destination on simulated chess board and finds the shortest distance (moves) the knight piece will take to travel from start to destination. The program utilizes a tree structure where each position is considered a "node" and each possible moves from the current position is a child of said node. Each possible moves is then queued up and checked until destination has been found or there are no more moves. When found, it will output the current node and all of the previous nodes (parents) it took to get there (the path it took). User can also choose their own chess board size (default is set to 8) by modifying the initializing of the Board/Knight class. 

There are usually more than one way to get from start to destination. This program will only print one of those possible paths.

To run *knight-moves.rb* :
```
$ cd knight-traverse
$ ruby knight-moves.rb
```

![alt text](https://github.com/duyklai/ruby-ds/blob/master/images/knights.jpg "Sample Knight Traversal Test")