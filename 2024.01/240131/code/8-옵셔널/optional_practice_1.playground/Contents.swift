import UIKit

/*:옵셔널 개념*/
//pass

/*:옵셔널값의 추출 방법*/
// if let
var myName : String?

if let name = myName {
    print(name)
}

// guard let
var myNum : Int?

func nilCheck(myNum : Int?) {
    guard let num = myNum else {
        print("nil")
        return
    }
    print(num)
}

nilCheck(myNum: nil)

// Nil-coalescing

var id : String?

var InputID = id ?? "아이디를 입력해주세요"

// 강제추출

// nil 확인 후 강제 추출
var myWord : String?
if myWord != nil {
    print(myWord)
}

// 함수와 옵셔널 타입

func notDefaultNil(name: String?){
    print(name)
}
notDefaultNil(name: nil)

func defaultNil(name: String? = nil){
    print(name)
}
defaultNil()

