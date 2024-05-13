//: [Previous](@previous)

import Foundation
import Combine


// Basic CombineLatest

let strPublisher = PassthroughSubject<String, Never>()
let intPublisher = PassthroughSubject<Int, Never>()

strPublisher.combineLatest(intPublisher).sink { (String, Int) in
    print("str : \(String) , int : \(Int)")
}

strPublisher.send("가")
intPublisher.send(1)
intPublisher.send(2)
strPublisher.send("나")
intPublisher.send(3)
strPublisher.send("다")


// Advanced CombineLatest





// Merge



//: [Next](@next)

