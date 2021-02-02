import UIKit

func insertionSort(_ array: [Int]) -> [Int] {
    var sortedArray = array
    
    for index in 1..<sortedArray.count {
        var currentIndex = index
        while currentIndex > 0 && sortedArray[currentIndex] < sortedArray[currentIndex - 1] {
            sortedArray.swapAt(currentIndex - 1 , currentIndex)
            currentIndex -= 1
        }
    }
    
    return sortedArray
}

func insertionSort2(_ array: [Int]) -> [Int] {
    var sortedArray = array
    for index in 1..<sortedArray.count {
        var currentIndex = index
        let temp = sortedArray[currentIndex]
        while currentIndex > 0 && temp < sortedArray[currentIndex - 1] {
            sortedArray[currentIndex] = sortedArray[currentIndex - 1]
            currentIndex -= 1
        }
        sortedArray[currentIndex] = temp
    }
    return sortedArray
}

func genericInsertionSort<T>(_ array: [T], _ isOrderedBefore: (T, T) -> Bool) -> [T] {
    var sortedArray = array
    for index in 1..<sortedArray.count {
        var currentIndex = index
        let temp = sortedArray[currentIndex]
        while currentIndex > 0 && isOrderedBefore(temp, sortedArray[currentIndex - 1]) {
            sortedArray[currentIndex] = sortedArray[currentIndex - 1]
            currentIndex -= 1
        }
        sortedArray[currentIndex] = temp
    }
    return sortedArray
}

//we have 2 nested loops in function so -> O(n^2)

let list = [ 10, -1, 3, 9, 2, 27, 8, 5, 1, 3, 0, 26 ]
insertionSort(list)
insertionSort2(list)
genericInsertionSort(list, >)

