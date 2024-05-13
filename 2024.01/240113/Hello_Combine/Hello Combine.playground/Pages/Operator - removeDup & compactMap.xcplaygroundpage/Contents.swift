//: [Previous](@previous)

import Foundation
import Combine

var subscriptions = Set<AnyCancellable>()

// removeDuplicates

let intPublisher = [1, 1, 2, 2, 3].publisher

let subsciption1 = intPublisher.sink { value in
    print(value)
}
let subscription2 = intPublisher
    .removeDuplicates()
    .sink {print($0)}

// compactMap

let strPublisher = ["1", "hi", "bye", "2"].publisher
let compactMapSubscription = strPublisher
    .compactMap { Float($0)}
    .sink { print($0) }

// ignoreOutput -> receive는 하는데 Output만 없는 것

let numbers = (1...5).publisher
numbers
    .print()
    .ignoreOutput()
    .sink {print($0)} receiveValue: {print($0)}

// prefix -> 자르기

numbers
    .prefix(2)
    .sink{print($0)}

//: [Next](@next)
