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
        set {
            self.weight = newValue * (height * height) / 10000
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

