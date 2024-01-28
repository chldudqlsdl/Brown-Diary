import UIKit

var greeting = "Hello, playground"

// Switch Basic

var score : Int = 50

switch score {
case 0...20 :
    print("가")
case 21...40 :
    print("양")
case 41...60 :
    print("미")
case 61...80 :
    print("우")
case 81...100 :
    print("수")
default :
    print("측정불가")
}

// Switch 응용 -> 바인딩(다른 상수/변수의 식별자로 할당) 하고 나서 , where 조건절 사용하기

switch score {
case let x where x % 2 == 0 :
    print("짝수 입니다")
default :
    print("홀수 입니다")
}



