import UIKit

// switch 문 where

//let score = 50
//
//switch score {
//case let score where score == 50 :
//    print("반타작")
//default :
//    print("!반타작")
//}

// 튜플

//let profile = (name : "brown" , age : 30 , location : "pohang")
//
//switch profile {
//case let profile where profile.age == 30 :
//    print("서른")
//default:
//    break
//}
//
//switch profile {
//case (let name , let age , let location) :
//    print("\(name)")
//default :
//    break
//}
//
//switch profile {
//case ("brown", 30 , "pohang") :
//    print("브라운 인증")
//default :
//    break
//}
//
//switch profile {
//case let(x, y, z) :
//    print("브라운 인증")
//default :
//    break
//}

// inout 키워드

//var a = 5
//var b = 10
//
//func inoutTest(a: inout Int, b: inout Int){
//    a *= 2
//    b *= 2
//}
//
//inoutTest(a: &a, b: &b)

// 옵셔널

//var name : String?
//
//switch name {
//case .some(let x) :
//    print(x)
//case .none :
//    print("nil")
//}

// array enumerated

//var nums = [10, 11, 12, 13, 14]
//
//for tuple in nums.enumerated() {
//    print(tuple)
//}

// Enum 연관값 바인딩

enum Direction {
    case left(degree: Int)
    case right(degree: Int)
}

var direction = Direction.left(degree: 90)

if case .left(let degree) = direction {
    print(degree)
}


