//: [Previous](@previous)

import Foundation
import Combine

let arrPublisher = [1, 2, 3, 4, 5].publisher

let queue = DispatchQueue(label: "custom")

let subcription = arrPublisher
    .subscribe(on: queue)
    .map({ value in
        print("value : \(value) , thread : \(Thread.current)")
        return value * 2
    })
//    .receive(on: DispatchQueue.main)
    .sink { value in
    print("value : \(value) , thread : \(Thread.current)")
}


//: [Next](@next)
