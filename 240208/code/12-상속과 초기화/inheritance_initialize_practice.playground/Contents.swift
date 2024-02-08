import UIKit

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

// 생성자
// 구조체의 지정생성자 편의생성자

struct Animal {
    var rabbit, fox, tutle : String
    
    init(rabbit: String, fox: String, tutle: String) {
        self.rabbit = rabbit
        self.fox = fox
        self.tutle = tutle
    }
    
    init(animal : String){
        self.init(rabbit: animal, fox: animal, tutle: animal)
    }
}

var infestedAnimals = Animal(animal: "infested")
infestedAnimals.fox

class Fish {
    var shark, ray : String
    
    init(shark: String, ray: String) {
        self.shark = shark
        self.ray = ray
    }
    
    convenience init(status : String) {
        self.init(shark: status, ray: status)
    }
}

class MiniFish : Fish {
    var nemo : String
    
    init(shark : String, ray: String, nemo: String) {
        self.nemo = nemo
        super.init(shark: shark, ray: ray)
    }
    
    convenience init(status: String) {
        self.init(shark: status, ray: status, nemo: status)
    }
}

var miniFish = MiniFish(status: "cured")

// 생성자의 상속과 재정의

class Mammal {
    var legs = 4
    
    init(legs: Int) {
        self.legs = legs
    }
}

class Elephant : Mammal {
    var longNose : Bool
    
    override init(legs: Int) {
        self.longNose = true
        super.init(legs: legs)
    }
}

// 하위클래스에서 편의생성자로 재정의


// 지정생성자 자동 상속

class Glucose {
    var GI : Int
    
    init(GI: Int) {
        self.GI = GI
    }
    
    convenience init() {
        self.init(GI: 0)
    }
}

class Rice : Glucose {
    var gram : Int
    
//    init(gram: Int, GI: Int) {
//        self.gram = gram
//        super.init(GI: GI)
//    }
    init(gram : Int) {
        self.gram = 100
        super.init(GI: 100)
    }
}

//var rice1 = Rice(GI: 70)
//var rice2 = Rice()

// 필수 생성자

//class View : UIView {
//    init() {
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}

// 열거형의 생성자?

enum Mammals {
    case dog
    case cat
    case human
    
    init?(name : String) {
        switch name {
        case "brown" :
            self = .human
        case "charlie" :
            self = .dog
        default :
            return nil
        }
    }
}

var quiz = Mammals(name: "ch")
quiz

// 실패가능생성자

class Document {
    
    var name: String?
    
    init() {}                // 서류 생성 (실패불가능) (이름은 nil로 초기화)
    
    init(name: String) {    // 실패가능 생성자 ===> 이름이 "" 빈문자열일때, 초기화 실패(nil)
//        if name.isEmpty { return nil }
        self.name = name
    }
}


// 자동으로 이름지어지는 서류

class AutomaticallyNamedDocument: Document {
    
    override init() {                // 재정의 (상위) 실패불가능 =====> (하위) 실패불가능
        super.init()
        self.name = "[Untitled]"
    }
    
    override init(name: String) {    // 재정의 (상위) 실패가능 =====> (하위) 실패불가능
        super.init()                 // 실패불가능 활용가능
        if name.isEmpty {
            self.name = "[Untitled]"
        } else {
            self.name = name
        }
    }
}
