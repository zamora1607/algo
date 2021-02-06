import UIKit

//There is only one possible place where the new element can be inserted in the tree. Finding this place is usually quick. It takes O(h) time, where h is the height of the tree.

public class BinarySearchTree<T: Comparable> {
    private(set) public var value: T
    private(set) public var parent: BinarySearchTree?
    private(set) public var left: BinarySearchTree?
    private(set) public var right: BinarySearchTree?
    
    public init(value: T) {
        self.value = value
    }
    
    public convenience init(array: [T]) {
        precondition(array.count > 0)
        self.init(value: array.first!)
        for v in array.dropFirst() {
            insert(value: v)
        }
    }
    
    public var isRoot: Bool {
        return parent == nil
    }
    
    public var isLeaf: Bool {
        return left == nil && right == nil
    }
    
    public var isLeftChild: Bool {
        return parent?.left === self
    }
    
    public var isRightChild: Bool {
        return parent?.right === self
    }
    
    public var hasLeftChild: Bool {
        return self.left != nil
    }
    
    public var hasRightChild: Bool {
        return self.right != nil
    }
    
    public var hasAnyChild: Bool {
        return hasLeftChild || hasRightChild
    }
    
    public var hasBothChildren: Bool {
        return hasLeftChild && hasRightChild
    }
    
    // how many nodes are in the subtree
    public var count: Int {
        return (left?.count ?? 0) + 1 + (right?.count ?? 0)
    }
    
    public func insert(value: T) {
        if value < self.value {
            if let left = left {
                left.insert(value: value)
            } else {
                left = BinarySearchTree<T>(value: value)
                left?.parent = self
            }
        } else {
            if let right = right {
                right.insert(value: value)
            } else {
                right = BinarySearchTree<T>(value: value)
                right?.parent = self
            }
        }
    }
    
    public func search(value: T) -> BinarySearchTree? {
        if value < self.value {
            return left?.search(value: value)
        } else if value > self.value {
            return right?.search(value: value)
        } else {
            return self  // value == self.value
        }
    }
    
    public func searchWithLoop(value: T) -> BinarySearchTree? {
        var node: BinarySearchTree? = self
        while let n = node {
            if value < n.value {
                node = n.left
            } else if value > n.value {
                node = n.right
            } else {
                return node
            }
        }
        return nil
    }
    
    public func traverseInOrder(process: (T) -> Void) {
        left?.traverseInOrder(process: process)
        process(value)
        right?.traverseInOrder(process: process)
    }
    
    public func traversePreOrder(process: (T) -> Void) {
        process(value)
        left?.traversePreOrder(process: process)
        right?.traversePreOrder(process: process)
    }
    
    public func traversePostOrder(process: (T) -> Void) {
        left?.traversePostOrder(process: process)
        right?.traversePostOrder(process: process)
        process(value)
    }
    
    public func map(formula: (T) -> T) -> [T] {
        var a = [T]()
        if let left = left { a += left.map(formula: formula) }
        a.append(formula(value))
        if let right = right { a += right.map(formula: formula) }
        return a
    }
    
    public func toArray() -> [T] {
        return map { $0 }
    }
    
    private func reconnectParentTonode(node: BinarySearchTree?) {
        if let parent = parent {
            if isLeftChild {
                parent.left = node
            } else {
                parent.right = node
            }
        }
        node?.parent = parent
    }
    
    public func minimum() -> BinarySearchTree {
        var node = self
        while let next = node.left {
            node = next
        }
        return node
    }
    
    public func maximum() -> BinarySearchTree {
        var node = self
        while let next = node.right {
            node = next
        }
        return node
    }
    
    @discardableResult public func remove() -> BinarySearchTree? {
        let replacement: BinarySearchTree?
        
        if let right = right {
            replacement = right.minimum()
        } else if let left = left {
            replacement = left.maximum()
        } else {
            replacement = nil
        }
        
        replacement?.remove()
        
        replacement?.right = right
        replacement?.left = left
        right?.parent = replacement
        left?.parent = replacement
        reconnectParentTonode(node: replacement)
        
        parent = nil
        left = nil
        right = nil
        
        return replacement
    }
    
    public func height() -> Int { //O(n)
        if isLeaf {
            return 0
        } else {
            return 1 + max(left?.height() ?? 0, right?.height() ?? 0)
        }
    }
    
    public func depth() -> Int { //O(h)
        var node = self
        var edges = 0
        while let parent = node.parent {
            node = parent
            edges += 1
        }
        return edges
    }
    
    public func predecessor() -> BinarySearchTree<T>? { //O(h)
        if let left = left {
            return left.maximum()
        } else {
            var node = self
            while let parent = node.parent {
                if parent.value < value { return parent }
                node = parent
            }
            return nil
        }
    }
    
    public func successor() -> BinarySearchTree<T>? { //O(h)
        if let right = right {
            return right.maximum()
        } else {
            var node = self
            while let parent = node.parent {
                if parent.value > value { return parent }
                node = parent
            }
            return nil
        }
    }
    
    public func isBST(minValue: T, maxValue: T) -> Bool {
        if value < minValue || value > maxValue { return false }
        let leftBST = left?.isBST(minValue: minValue, maxValue: value) ?? true
        let rightBST = right?.isBST(minValue: value, maxValue: maxValue) ?? true
        return leftBST && rightBST
    }
}

extension BinarySearchTree: CustomStringConvertible {
    public var description: String {
        var s = ""
        if let left = left {
            s += "(\(left.description)) <-"
        }
        s += "\(value)"
        if let right = right {
            s += " -> (\(right.description))"
        }
        return s
    }
}

let tree = BinarySearchTree<Int>(value: 7)
tree.insert(value: 2)
tree.insert(value: 5)
tree.insert(value: 10)
tree.insert(value: 9)
tree.insert(value: 1)

let newTree = BinarySearchTree<Int>(array: [7, 2, 5, 10, 9, 1])

print(tree)
print(newTree)

tree.search(value: 5)
tree.search(value: 2)
tree.searchWithLoop(value: 7)
tree.searchWithLoop(value: 6)

tree.traverseInOrder(process: {value in print(value)})

tree.toArray()
tree.height()

if let node = tree.search(value: 7) {
    node.depth()
}

if let node1 = tree.search(value: 1) {
    tree.isBST(minValue: Int.min, maxValue: Int.max)
    node1.insert(value: 100)
    tree.search(value: 100)
    tree.isBST(minValue: Int.min, maxValue: Int.max)
}
