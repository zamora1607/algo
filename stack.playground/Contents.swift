import UIKit

struct Stack<T> {
    private var array = [T]()
    
    var isEmpty: Bool {
        return array.isEmpty
    }
    
    var count: Int {
        return array.count
    }
    
    var peek: T? {
        return array.last
    }
    
    mutating func push(_ element: T) {
        array.append(element) // O(1) (inserting at the beginning O(n))
    }
    
    mutating func pop() -> T? {
        return array.popLast()
    }
}


