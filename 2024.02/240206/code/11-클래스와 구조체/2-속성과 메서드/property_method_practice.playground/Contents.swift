// 저장 속성
func howMuch() -> Int {
    return 5000
}

class Book {
    var price = howMuch()
}

var book = Book()
book.price

// 지연 저장 속성에 기본값이 없다면
// 오류가 난다 -> Lazy properties must have an initialize

//class Movie {
//    lazy var title
//}

// 계산 속성
class Person {
    var name: String = "사람"
    var height: Double = 160.0
    var weight: Double = 60.0
    
    var bmi: Double {
        get {
            let bmi = weight / (height * height) * 10000
            return bmi
        }
        set(yourWeight) {
            self.weight = yourWeight * (height * height) / 10000
        }
    }
}

var p = Person()
p.bmi
p.bmi = 30
p.weight

// 커스텀 계산속성

class Youtube {
    var subscibers : Int
    var wholeWatchingTime : Double
    
    var averageWatchingTime : Double {
        get {
            return wholeWatchingTime / Double(subscibers)
        }
        set {
            self.wholeWatchingTime = Double(subscibers) * newValue
        }
    }
    init(subscibers: Int, wholeWatchingTime: Double) {
        self.subscibers = subscibers
        self.wholeWatchingTime = wholeWatchingTime
    }
}

var brownYoutube = Youtube(subscibers: 1000, wholeWatchingTime: 140000)
brownYoutube.averageWatchingTime
brownYoutube.averageWatchingTime = 10
brownYoutube.wholeWatchingTime

// 타입속성
class Car {
    static let wheel : Int = 4
    static var count : Int = 0
    
    var brand : String
    var price : Double
    
    var commercial : String {
        get {
            return "you should have a \(brand) car"
        }
        set {
            price *= 2.0
        }
    }
    
    init(brand: String, price: Double) {
        self.brand = brand
        self.price = price
        Car.count += 1
    }
}

var benz = Car(brand: "benz", price: 1)
Car.wheel
Car.count
benz.commercial
benz.price
benz.commercial = ""
benz.price
var bmw = Car(brand: "bmw", price: 1.5)
Car.count

// 계산타입 속성
class Cat {
    static var species = "cat"
    static var doubleSpecies: String {
        get {
            return species + species
        }
        set{
            species = "dog"
        }
    }
}

Cat.doubleSpecies = "bye"
Cat.species

// 클래스의 인스턴스 메서드

class Room {
    var size : Double = 2.0
    
    func sizeChange(_ size : Double) {
        self.size = size
    }
    func sizeChange(_ isTrue : Bool) {
        if isTrue {
            self.size = 0.0
        }
    }
}

var room  = Room()
room.sizeChange(3.0)
room.size

// 구조체의 인스턴스 메서드
struct Hotel {
    var size : Double = 2.0
    
    mutating func sizeChange(_ size : Double) {
        self.size = size
    }
    
    mutating func sizeChange(_ isTrue : Bool) {
        if isTrue {
            self.size = 0.0
        } else {
            self.size = 10.0
        }
    }
}

var hotel = Hotel()
hotel.size
hotel.sizeChange(true)
hotel.size

// 타입 메서드

// 서브스크립트
class SomeData {
    var datas = [1, 2, 3, 4, 5]
    
    subscript(index: Int) -> Int {
        get {
            return datas[index]
        }
        set(parameter) {
            datas[index] =  parameter
        }
    }
}

var someData = SomeData()
someData[4] = 6
print(someData.datas)

// 파라미터 2개의 서브스크립트

class Matrix {
    var data = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
    
    subscript(a: Int, b : Int) -> Int {
        return data[a][b]
    }
}

var matrix = Matrix()
matrix[1, 2]

// 열거형에다가 타입 서브스크립트

enum Planet : Int {
    case mercury, venus, earth, mars, jupiter
    
    static subscript(index : Int) -> Planet {
        return Planet(rawValue: index)!
    }
}

Planet[3]

// 접근제어

class Swift {
    private var property = "private property"
    
    func access() {
        self.property = "open property"
    }
}

var swift = Swift()
swift.access()

// 싱글톤 실험실
class Singleton {
    static let shared = Singleton()
    
    var num = 100
    
    private init(num: Int = 100) {
        self.num = num
    }
}

let singleton = Singleton.shared
singleton.num
singleton.num = 777

//var notSingletion = Singleton()
//notSingletion.num

var doubleton = Singleton.shared
doubleton.num
