//: [Previous](@previous)

import Foundation
import Combine

// Publisher & Subscriber

let just = Just(1000)
let subscription1 = just.sink { value in
    print("Recieved Value : \(value)")
}

let arrayPublisher = [1, 2, 3, 4, 5].publisher
let subscription2 = arrayPublisher.sink { value in
    print("Recieved Value : \(value)")
}

class MyClass {
    var property: Int = 0 {
        didSet {
            print("Did set property to \(property)")
        }
    }
}

let object = MyClass()
let subscription3 = arrayPublisher.assign(to: \.property, on: object)



//: [Next](@next)









