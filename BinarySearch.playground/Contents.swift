import Foundation

let numbers = [11, 59, 3, 2, 53, 17, 31, 7, 19, 67, 47, 13, 37, 61, 29, 43, 5, 41, 23]
numbers.firstIndex(of: 43)

func linearSearch<T: Equatable>(_ a: [T], _ key: T) -> Int? {
    for i in 0..<a.count {
        if a[i] == key {
            return i
        }
    }
    return nil
}

// binary search O(n)

func binarySearch<T: Comparable>(_ a: [T], key: T, range: Range<Int>) -> Int? {
    if range.lowerBound >= range.upperBound {
        return nil
    } else {
        let midIndex = range.lowerBound + (range.upperBound - range.lowerBound) / 2
        
        if a[midIndex] > key {
            return binarySearch(a, key: key, range: range.lowerBound..<midIndex)
        } else if a[midIndex] < key {
            return binarySearch(a, key: key, range: midIndex..<range.upperBound)
        } else {
            return midIndex
        }
    }
}

//array for binary search must be ordered
let numbers2 = [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67]
let test = binarySearch(numbers2, key: 43, range: 0 ..< numbers2.count)

func binarySearch2<T: Comparable>(_ a: [T], key: T) -> Int? {
    var lowerBound = 0
    var upperBound = a.count
    
    while lowerBound < upperBound {
        let midIndex = lowerBound + (upperBound - lowerBound) / 2
        if a[midIndex] > key {
            upperBound = midIndex
        } else if a[midIndex] < key {
            lowerBound = midIndex
        } else {
            return midIndex
        }
    }
    return nil
}

binarySearch2(numbers2, key: 43)
