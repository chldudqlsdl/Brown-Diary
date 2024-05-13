import UIKit

// 튜플은 연관된 데이터의 조합이다~

// 선언
var brown1 = ("브라운", 30, "포항")

// 값 접근
brown1.0
brown1.1
brown1.2

// 네임드 튜플
var brown2 = (name : "브라운", age: 30, location : "포항")
brown2.name
brown2.age
brown2.location

// 바인딩이 가능해요 -> 오 이거 신기하다
let(name, age, location) = ("브라운", 30, "포항")

// 튜플의 활용

// 튜플은 Switch 랑 같이 사용되는 경우가 많다네?

var brown3 = ("브라운", 30)

switch brown3 {
case ("브라운", 10) :
    print("false")
case ("브라운", 30) :
    print("true")
default:
    break
}

// 튜플과 switch 바인딩 콜라보레이션

switch brown3 {
case let(x,y):
    print("이름 : \(x) , 나이 : \(y)")
default:
    break
}

// 여기다 where 조건절도 추가가능하겠지!
switch brown3 {
case let(x, y) where y == 30 :
    print(true)
default :
    print(false)
}

// 마지막으로 신기한 것 -> 걸러낼 수 있다..!
switch brown3 {
case (let x , 10):
    print(false)
case (let x , 30):
    print(true)
default:
    print(false)
}






