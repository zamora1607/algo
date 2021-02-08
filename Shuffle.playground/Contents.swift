import UIKit

extension Array {
    
    public mutating func shuffle() { //O(n^2)
        var temp = [Element]()
        while !isEmpty {
            let i = Int.random(in: 0..<count)
            let obj = remove(at: i) //O(n) n times
            temp.append(obj)
        }
        self = temp
    }
    
    public mutating func shuffle2() {
        for i in stride(from: count - 1, through: 1, by: -1) {
            let j = Int.random(in: 0...i)
            if i != j {
                self.swapAt(i, j)
            }
        }
    }
    
}

var list = [ "a", "b", "c", "d", "e", "f", "g" ]
list.shuffle()
list.shuffle()
list.shuffle()

list.shuffle2()
