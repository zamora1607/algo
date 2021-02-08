import UIKit

var str = "Hello, playground"

func countOccurences<T: Comparable>(of key: T, in array: [T]) -> Int {
    
    var leftBoundary: Int {
        var low = 0
        var high = array.count
        
        while low < high {
            let midIndex = low + (high - low)/2
            if array[midIndex] < key {
                low = midIndex + 1
            } else {
                high = midIndex
            }
        }
        return low
    }
    
    var rightBoundary: Int {
        var low = 0
        var hight = array.count
        
        while low < hight {
            let midIndex = low + (hight - low)/2
            if array[midIndex] > key {
                hight = midIndex
            } else {
                low = midIndex + 1
            }
        }
        return low
    }
    
    return rightBoundary - leftBoundary
}

let a = [ 0, 1, 1, 3, 3, 3, 3, 6, 8, 10, 11, 11 ]

countOccurences(of: 3, in: a)
