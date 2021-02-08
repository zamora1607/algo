import UIKit

func minimum<T: Comparable>(_ array: [T]) -> T? {
    guard var minimum = array.first else {
        return nil
    }
    
    for item in array.dropFirst() {
        minimum = item < minimum ? item : minimum
    }
    return minimum
}

func maximum<T: Comparable>(_ array: [T]) -> T? {
    guard var maximum = array.first else {
        return nil
    }
    
    for item in array.dropFirst() {
        maximum = item > maximum ? item : maximum
    }
    return maximum
}

let array = [8, 3, 9, 4, 6]
minimum(array)
maximum(array)

array.min()
array.max()

func minimumMaximum<T: Comparable>(_ array: [T]) -> (minimum: T, maximum: T)? {
    
    guard var minimum = array.first else {
        return nil
    }
    var maximum = minimum
    
    let start = array.count % 2
    for i in stride(from: start, to: array.count, by: 2) {
        let pair = (array[i], array[i+1])
        
        if pair.0 > pair.1 {
            if pair.0 > maximum {
                maximum = pair.0
            }
            if pair.1 < minimum {
                minimum = pair.1
            }
        } else {
            if pair.0 < minimum {
                minimum = pair.0
            }
            if pair.1 > maximum {
                maximum = pair.1
            }
        }
    }
    return (minimum, maximum)
}
