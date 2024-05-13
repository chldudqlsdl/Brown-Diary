//lazy

//struct Dog {
//    var name : String
//    
//    lazy var nickName : String = "MR.\(name)"
//}
//
//var dog = Dog(name: "Charlie")
//dog.nickName
//
//struct Bird {
//    var name: String
//    lazy var weight: Double = 0.2
//    
//}
//var bird = Bird(name: "Charlie")
//bird.weight // 이 시점에 초기화(메모리 공간 생성)

// 클래스 구조체 생성자

//struct Color {
//    var red : Int
//    var green : Int
//    
//    init(red: Int, green: Int) {
//        self.red = red
//        self.green = green
//    }
//}

// 편의생성자

//class Aclass {
//    var x: Int
//    var y: Int
//    
//    init(x: Int, y: Int) {    // 지정생성자 - 모든 저장 속성 설정
//        self.x = x
//        self.y = y
//    }
//    
//    init() {     // 편의생성자 - (조금 편리하게 생성) 모든 저장 속성을 설정하지 않음
//        self.init(x: 0, y: 0)
//    }
//}

//class Aclass {
//    var x: Int
//    var y: Int
//    
//    init(x: Int, y: Int) {    // 지정생성자 - 모든 저장 속성 설정
//        self.x = x
//        self.y = y
//    }
//    
//    convenience init() {     // 편의생성자 - (조금 편리하게 생성) 모든 저장 속성을 설정하지 않음
//        self.init(x: 0, y: 0)
//    }
//}
//
//class Bclass: Aclass {
//    var z: Int
//
////    init(x: Int, y: Int, z: Int) {    // 실제 메모리에 초기화 되는 시점
////        self.z = z                 // ⭐️ (필수)
////        super.init(x: x, y: y)     // ⭐️ (필수) 상위의 지정생성자 호출
////    }
////    
////    convenience init(z: Int) {
////        self.init(x: 0, y: 0, z: z)
////    }
////    
////    convenience init() {
////        self.init(z: 0)
////    }
////    
////    override init(x: Int, y: Int) {
////        self.z = 0
////        super.init(x: x, y: y)
////    }
//
//}

// 실패가능 생성자

//class Animal {
//    let species: String
//    
//    init?(species: String) {
//        if species.isEmpty {
//            return nil            // 생성자 내에서 실패 가능 부분에 nil을 리턴하면 됨
//        }
//        self.species = species
//    }
//}
//
//class Human : Animal {
//    override init(species: String) {
//        super.init(species: "인간")
//    }
//}

// 클로저메모리 누수

class Dog {
    var name = "초코"
    
    var run: (() -> Void)?
    
    func saveClosure() {
        // 클로저를 인스턴스의 변수에 저장
        run = { [weak self] in
            print("\(self?.name)가 뛴다.") // RC + 1
        }
    }
    
    deinit {
        print("디이닛")
    }
}

func doSomething() {
    let choco: Dog? = Dog()
    choco?.saveClosure()  // RC + 1 강한 참조사이클 일어남 (메모리 누수가 일어남)
}

doSomething()



