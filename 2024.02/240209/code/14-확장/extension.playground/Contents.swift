import UIKit
// 멤버의 확장

extension Double {
    static var zero: Double { return 0.0 }
}

Double.zero

extension Int {
    var squared: Int {
        return self * self
    }
}

func squared(num: Int) -> Int {     // 이런식으로 함수를 만드는 것보다 훨씬 간단하고, 더 간결하게 만들 수 있음
    return num * num
}

squared(num: 4)

// 익스텐션 테스트

class Person {
    var name = "brown"
}

extension Person {
    var tellMeYourNmae : String {
        return "I'm \(self.name)"
    }
}

Person().tellMeYourNmae

// 익스텐션 생성자
extension UIColor {      // 익스텐션 + 편의생성자 조합
    
    convenience init(color: CGFloat) {   // Float   / Double
        self.init(red: color/255, green: color/255, blue: color/255, alpha: 1)
    }

}
struct Point {
    var x, y : Double
    
    init(x: Double, y: Double) {
        self.x = x
        self.y = y
    }
    
    //init()
}

extension Point {
    init(num: Double) {
        self.init(x: num, y: num)
    }
}

//extension Point {
//    init(num: Double) {
//        self.x = num
//        self.y = num
//    }
//}


