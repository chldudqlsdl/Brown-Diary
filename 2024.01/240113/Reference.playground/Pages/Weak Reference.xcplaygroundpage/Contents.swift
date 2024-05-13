//: [Previous](@previous)

import Foundation

class Person {
    var name: String
    
    weak var apartment: Apartment?

    init(name: String) {
        self.name = name
    }
}

class Apartment {
    weak var tenant: Person?
}

var person: Person? = Person(name: "Bob")
var apartment: Apartment? = Apartment()
person?.apartment = apartment
apartment?.tenant = person

person = nil
person?.apartment
//강한순환참조 발생 : person이 없는데도 tenant가 찍힌다
//해결법 : 약한 참조 (Weak Reference)
apartment?.tenant?.name

//apartment = nil
//person?.apartment


//: [Next](@next)
