import UIKit

/*:
  switch 문
 */

// 기본
var brn : Int = 30

switch brn {
case 10...20 :
    print(false)
case 21...30 :
    print(true)
default :
    break
}

// where 조건
switch brn {
case let x where x > 29 :
    print(true)
default :
    break
}
/*:
 튜플
 */
// 기본
var gry = ("그레이", 20, "서울")

gry.0
gry.1
gry.2

// 활용
// 바인딩 과 거르기
switch gry {
case (let x , 0 , "서울") :
    print(false)
default :
    print(true)
}
/*:
 삼항연산자
 */
// 기본

var human = ["운"]

let country = human.contains("운") ? "s.korea" : "n.korea"
/*:
 범위연산자, 패턴매칭 연산자
 */
// 언제 쓰나 -> switch, for, ??? => 위에 참조

// 패턴매칭 연산자 : 범위연산자의 참 거짓 판별 후 리턴

1...30 ~= 20
