//: [Previous](@previous)

import Foundation
import Combine

// Transform - Map
let firstPublisher = PassthroughSubject<Int, Never>()
let subscription1 = firstPublisher
    .map({ $0 * 2 })
    .sink { value in
    print(value)
}
firstPublisher.send(100)

// Filter
let secondPublisher = PassthroughSubject<String, Never>()
let subscription2 = secondPublisher
    .filter({ $0.contains("a")})
    .sink { value in
    print(value)
}

secondPublisher.send("jenny")
secondPublisher.send("jason")
secondPublisher.send(completion: .finished)


//: [Next](@next)
