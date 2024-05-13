//: [Previous](@previous)

import Foundation

class MyClass {
    var value = 10

    func someFunction() {
        print(value)
//        DispatchQueue.global().async {
//            // 경고: Implicit use of 'self' in closure; use 'self.' to make capture semantics explicit
//            print(self.value)
//        }
    }
}

//: [Next](@next)
