import UIKit

var greeting = "Hello, playground"

// func
func rollDice() -> Int {
    return Int.random(in: 1...6)
}
rollDice()

// Closure
// 상수에 함수 할당하고 그 상수호출하기
func call(name:String) {
    print("Hello, \(name)")
}
let callName = call
callName("Brown")

// 상수에 클로저 할당하고, 그 상수호출하기
// in 을 통해 파라미터 및 반환 타입과 클로저 코드 분리
let heyName = {(name: String) in
    print("Hey, \(name)")
}
heyName("Charlie")

// 클로저는 배열∙딕셔너리 같은 컬렉션 타입과 함께, filter∙map∙reduce 메소드 사용 시 자주 활용
// filter : 조건 만족하는 요소들을 다시 배열로
let members = ["Brown", "Blue", "Black", "Green"]
let oldMembers = members.filter {name in
    return name.hasPrefix("B")
}

// map : 조건 만족하는 요소들을 변환하여 다시 배열로
let nums = [1, 2, 3, 4]
let oldNums = nums.map {element -> Int in
    return (element > 2) ? element * 2 : element * 100
}
// 클로저 축약
let olderNums = nums.map {($0 > 2) ? $0 * 2 : $0 * 100}

// reduce : 배열 요소들을 계산하여 얻은 값 -> 누산기?
let money = [10000, 50000, 100000]
let totalMoney = money.reduce(0) { partialResult, element in
    return partialResult + element
}

