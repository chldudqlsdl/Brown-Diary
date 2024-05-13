//: [Previous](@previous)

import Foundation

import Foundation

class Person {
    var name: String
    
    var apartment: Apartment?

    init(name: String) {
        self.name = name
    }
}

class Apartment {
    unowned var tenant: Person?
}

var person: Person? = Person(name: "Bob")
var apartment: Apartment? = Apartment()
person?.apartment = apartment
apartment?.tenant = person

person = nil
person?.apartment
//강한순환참조 발생 : person이 없는데도 tenant가 찍힌다
//해결법 : 약한 참조 (Weak Reference)
apartment?.tenant

//apartment = nil
//person?.apartment

//: [Next](@next)
