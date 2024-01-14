//: [Previous](@previous)

import Foundation

class Person {
    var name: String

    init(name: String) {
        self.name = name
    }
}

var person1 : Person? = Person(name: "John")
var person2 : Person? = person1
person1 = nil
CFGetRetainCount(person2)

//강한 참조
// person1이 nil로 설정되어도 person2가 참조하므로 메모리에서 해제되지 않음

//: [Next](@next)
