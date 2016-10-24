
# FOCS Homework 15, for Day 15

You may edit your answers into this file, or add a separate file in the same directory.

If you add a separate file, please include the following at the top:

```
Student Name: Aidan McLaughlin
Check one:
[ ] I completed this assignment without assistance or external resources.
[X] I completed this assignment with assistance from ___
   and/or using these external resources: __Wikipedia__ and started looking at __https://courses.csail.mit.edu/6.006/fall09/lecture_notes/lecture04.pdf__ 
```


## I. Binary search tree ordering


Assume that the following tree structures are all properly constructed binary search trees, preserving the binary search property that any (internal) node's left child is smaller than the internal node and its right child is larger (or of equal value).  

Anything labeled with a T can be assumed to be a (possibly empty) subtree (i.e., may contain zero or more nodes); anything labeled with a lower case letter is a single node.

What inequalities must hold in each of these trees?

### 0.
```
        a
       / \
      /   \
    T1     T2
```

Ans:  all elements of TI <= x <= all elements of T2

### 1.
```
        b
       / \
      /   \
     c     T3
    / \
   /   \
 T1    T2
```

Ans: T1 elements <= c <= T2 elements, c <= b <= T3 elements



### 2.
```
        d
       / \
      /   \
    T1     e
          / \
         /   \
       T2    T3
```

Ans: T1 elements <= d <= e, T2 elements <= e <= T3 elements



### 3.
```
        f
       / \
      /   \
     g     T4
    / \
   /   \
 T1     h
       / \
      /   \
    T2     T3
```

Ans: T1 elements <= g <= h, T2 elements <= h <= T3 elements, g <= f <= T4 elements



## II.  Extending this analogy:  drawing trees.

### 4. 

What other tree structures containing three internal nodes -- x, y, and z -- can exist?  Draw these and describe the inequalities that exist among the internal nodes and their subtrees.  
[Hint:  There should be four more shapes.]  
The relationship among x, y, and z doesn't matter.  For convenience, we've arbitrarily labeled them top to bottom and the subtrees left to right.<br>
Tree 1 <br>
<img src="https://github.com/aidankmcl/focs-assignments/blob/master/day15/hwk15-focs-tree1.png" width="300"> <br>
Tree 2 <br>
<img src="https://github.com/aidankmcl/focs-assignments/blob/master/day15/hwk15-focs-tree2.png" width="300"> <br>
Tree 3 <br>
<img src="https://github.com/aidankmcl/focs-assignments/blob/master/day15/hwk15-focs-tree3.png" width="300"> <br>
Tree 4 <br>
<img src="https://github.com/aidankmcl/focs-assignments/blob/master/day15/hwk15-focs-tree4.png" width="300"> <br>

## III.  Observing balance

It is desirable for binary search trees to be balanced (or close).  If we assume that each of the T structures has the same depth, the two-internal-node trees have the following property:

For EVERY internal node (x and y), the depth of the internal node's left subtree and the depth of the internal node's right subtree differ by at most 1.  We call these trees almost-balanced.  


## IV.  Maintaining balance

Observe the following:

If you are given a binary tree of the form in question 1, you can transform them into the form in question 2 (and vice versa) while preserving the binary search property.  
[Since they are both almost-balanced, this doesn't help, but it also doesn't hurt.]  


### 5. 

Does this property hold for any of the three-internal-node trees?  Which ones?  Which ones are NOT almost-balanced?  (We call these unbalanced.)

Answer: Only the first tree is balanced. <br>


### 6. 

Use this insight to show how to modify each of the unbalanced tree forms with three internal nodes into an almost-balanced tree that preserves the binary search property.<br>
<br>
Tree 2 - Move `y` to the top and turn `x` into the right child of it.<br>
```
         y
        /  \
       /    \
      z      x
     /\      /\  
    /  \    /  \ 
   T1  T2  T3  T4
```
<br>
Tree 3 - Move `z` to the top and turn `x` into the left child of it.<br>
```
         z
        /  \
       /    \
      x      y
     /\      /\  
    /  \    /  \ 
   T1  T2  T3  T4
```
<br>
Tree 4 - Move `y` to the top and turn `x` into the left child of it.<br>
```
         y
        /  \
       /    \
      x      z
     /\      /\  
    /  \    /  \ 
   T1  T2  T3  T4
```
<br>



## V.  Rebalancing

### 7. 

Verify that the following tree is almost-balanced:

For EVERY internal node (x and y), the depth of the internal node's left subtree and the depth of the internal node's right subtree differ by at most 1. 

```
         8
        / \
       /   \
      6     14
     /\      /\  
    /  \    /  \ 
   3   7   12   16  
  /\       /    /\ 
 /  \     /    /  \ 
2    5   10   15   20
                   /
                  /
                 18
```



### 8. 

Insert the value 13 into this tree.  Where does it go?  Is the resulting tree almost-balanced?  If not, see #11.

```
          8
        /   \
       /     \
      6       14
     /\      /  \  
    /  \    /    \ 
   3   7   12     16  
  /\      / \      /\ 
 /  \    /   \    /  \ 
2    5  10  (13) 15   20
                      /
                     /
                    18
```

Answer: Right child of the 12. The resulting tree is almost-balanced.


### 9. 

Insert the value 17 into the tree.  Where does it go?  Is the resulting tree almost-balanced?  If not, see #11.

```
          8
        /   \
       /     \
      6       14
     /\      /  \  
    /  \    /    \ 
   3   7   12     16  
  /\      / \      /\ 
 /  \    /   \    /  \ 
2    5  10   13  15   18
                      / \
                     /   \
                   (17)  20
```

Answer: Replace 20 with 18 (making 20 its right child) and make 17 the left child of 18.


### 10. 

Insert the value 4 into the tree.  Where does it go?  Is the resulting tree almost-balanced?  If not, see #11.

```
          8
        /   \
       /     \
      6       14
     /\      /  \  
    /  \    /    \ 
   3   7   12     16  
  /\      / \      /\ 
 /  \    /   \    /  \ 
2   (4) 10   13  15   18
      \               / \
       \             /   \
        5          (17)  20
```

Answer: Make right child of 3 and move 5 to right child of 4. Resulting tree is unbalanced.


### 11. 

Use the work you've done above to rebalance the tree.  Start at the newly inserted value; work up until you find an internal node that has left and right children whose depth differs by more than one.  Rebalance that subtree using the processes you created in #6.  Continue to climb the tree, rebalancing any unbalanced (not almost-balanced) nodes as you go up.


```
          ___ 8 __
         /        \
        /          \
     (5)            14
     /\            /   \  
    /  \          /     \ 
   3    6        12      16  
  /\     \       / \      /\ 
 /  \     \     /   \    /  \ 
2    4     7   10   13  15   18
                             / \
                            /   \
                           17   20
```

Answer: Exchange 5 for 6 and move 6 & 7 down to 5's right child.


### 12. 

[Challenge] Assuming that a tree is almost-balanced when you make an insertion, and that that insertion may violate the almost-balanced property, can almost-balance always be restored solely by climbing the  path from the newly inserted node to the root?  Will you ever have to descend another branch?  Why or why not?











