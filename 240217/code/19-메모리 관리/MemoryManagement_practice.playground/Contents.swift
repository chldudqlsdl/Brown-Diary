// weak 실험

class Dog {
    unowned var owner : Person?
    
    deinit {
        print("멍멍이 해제")
    }
}

class Person {
    var pet : Dog?
    
    deinit {
        print("인간 해제")
    }
}

var dog : Dog? = Dog()
var person : Person? = Person()

dog?.owner = person
person?.pet = dog

person = nil
dog = nil
