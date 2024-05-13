import UIKit

/*:참고) 함수 실행의 메모리 구조*/
//pass
/*:조건문과 반복문의 명령어(CPU) 구조*/
//pass
/*:inout 파라미터*/
var a = 5
var b = 10

func inoutTest(a: inout Int, b: inout Int){
    a *= 2
    b *= 2
}

inoutTest(a: &a, b: &b)

print(a, b)
/*:guard문*/

var myMoney : Int = 1000

// 생각해보면 guard 는 return, throw, break, continue 가 있어야 하니까 함수나 반복문 내부에서만 쓰일 수 있구나!?

func guardTask(enterYourMoney money: Int) {
    guard money > 10000 else {return}
    print("welcome")
}

guardTask(enterYourMoney: myMoney)

/*:@discardableResult*/

func myfunc() -> String {
    return "브라운"
}

myfunc()

_ = myfunc()


