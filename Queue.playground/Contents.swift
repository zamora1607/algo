import Foundation

struct Queue<T> {
    fileprivate var array = [T?]()
    fileprivate var head = 0
    
    var isEmpty: Bool {
        array.isEmpty
    }
    
    var count: Int {
        array.count - head
    }
    
    mutating func enqueue(_ element: T) { //O(1)
        array.append(element)
    }
    
//    mutating func dequeue() -> T? { //O(n)
//        if isEmpty {
//            return nil
//        } else {
//            return array.removeFirst()
//        }
//    }
    
    
    mutating func dequeue() -> T? {
        guard head < array.count, let element = array[head] else {
            return nil
        }
        
        array[head] = nil
        head += 1
        
        let percentage = Double(head) / Double(array.count)
        if array.count > 50 && percentage > 0.25 {
            array.removeFirst(head)
            head = 0
        }
        return element
    }
    
    public var front: T? {
        if isEmpty {
            return nil
        } else {
            return array[head]
        }
    }
}


var queue = Queue<String>()
queue.array
queue.enqueue("tadam")
queue.enqueue("sasa")
queue.enqueue("trololo")
queue.array
queue.count

queue.dequeue()
queue.array
queue.count

queue.enqueue("grace")
queue.array
queue.count
