// as?
class Person {
    var id = 1
    func say() {
        print("mmm")
    }
}

class Student : Person {
    var studentId = 10
    override func say() {
        print("Hello")
    }
}

var person = Person()
var student = Student()

var preStudent = student as Person

var specialPerson = Student() as Person

if let specialPerson = specialPerson as? Student {
    specialPerson.studentId
}

var newPerson = specialPerson as! Student

specialPerson.say()

// 상속과 다형성

// Any

var anyTest : Any = 4
anyTest = 5

var test = anyTest as? String
test?.count // 이게 바로 옵셔널 체이닝 리턴 값이 옵셔널이다

