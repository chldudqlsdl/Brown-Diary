
// 상속
class Person {
    var id = 0
    var name = "이름"
    var email = "abc@gmail.com"
}


class Student: Person {
    // id
    // name
    // email
    
    var studentId = 0
}



class Undergraduate: Student {
    // id
    // name
    // email
    // studentId
    
    var major = "전공"
}

// 상속과 재정의

class Vehicle {
    
    var currentSpeed = 0.0
    
    var halfSpeed : Double {
        get {
            return self.currentSpeed / 2
        }
        set {
            self.currentSpeed = newValue * 2
        }
    }
    func blowTheHorn() {
        print("meow")
    }
}

class Car : Vehicle {
    
    var wheelCount = 4
    
    override var currentSpeed : Double {
        get {
            return super.currentSpeed
        }
        set {
            super.currentSpeed = newValue
        }
    }
//    override var currentSpeed : Double {
//        didSet {
//            print("값이 \(oldValue) 에서 \(currentSpeed) 로 바뀌었습니다.")
//        }
//    }
//    override var halfSpeed: Double {
//        get {
//            return super.halfSpeed / 3
//        }
//        set {
//            super.halfSpeed = newValue * 3
//        }
//    }
    override var halfSpeed: Double {
        didSet {
            print("\(oldValue) 에서 \(halfSpeed) 로 변경되었습니다")
        }
    }
    override func blowTheHorn() {
        super.blowTheHorn()
        print("bow-wow")
    }
}

var vehicle = Vehicle()
vehicle.halfSpeed = 40.0
vehicle.currentSpeed

var car = Car()
car.halfSpeed = 20.0
car.currentSpeed
car.blowTheHorn()

//초기화의 과정과 생성자

struct Color {
    let red: Double = 0.0
    let green: Double = 0.0
    let blue: Double = 0.0
}

var color = Color()
