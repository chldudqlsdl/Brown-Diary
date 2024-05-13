import UIKit

/*: func
 */

// 기본형태
// 용어를 잘 구분해서 사용합시다
// (name: String) -> 파라미터, 매개변수, 인자
// name -> 파라미터의 이름
// Stirng -> 파라미터의 타입
// -> String -> 리턴 타입
// "아이유" -> 아규먼트, 인수
func introduce(name: String) -> String {
    return "저는 \(name)입니다"
}
introduce(name: "아이묭")

// 리턴타입을 꼭 써줘야하나? => 꼭 써줘야하는군, 안쓰면 에러
func saySomthing() -> String {
    return "안녕하세요"
}

// 함수도 표현식이 될 수 있어요. 단, 리턴타입이 있는 경우

var word = introduce(name: "아이묭")
print(introduce(name: "아이묭"))

// Void vs 리턴타입이 있는 녀석

func cannotSay(name: String) {
    
}

// Void : 이렇게 잘 안 사용합니다
var quiet = cannotSay(name: "아이묭")

/*: 함수의 응용
 */

// 아규먼트 레이블

func inputYourName(성 lastname : String, 이름 firstname : String) {
    print(lastname + firstname)
}

inputYourName(성: "브", 이름: "라운")

// 파라미터이름 생략
func myPrint(_ word : String) {
    print(word)
}
myPrint("안녕하세요")

// 가변 파라미터
func averageMaker(_ numbers : Double...) {
    var total = 0.0
    for i in numbers {
        total += i
    }
    print(total / Double(numbers.count))
}

averageMaker(4.2 , 3.7 , 2.1)

// 기본값 설정 파라미터
func form(_ name: String = "홍길동") {
    print("이름 : \(name)")
}

form()
form("브라운")

/*: 함수 사용시 주의점
 */
// 파라미터는 상수이다
//func func1(a : Int) {
//    a = 2
//    return a
//}

// Scope : 함수 내에서 선언한 변수는 내에서만 사용 -> 당연한 내용

// return 키워드 : 리턴 타입이 없어도 쓸수 있고, 쓰는 즉시 함수 중지

// 함수의 실행문 : 함수를 호출하는 것 자체로 표현식이다(리턴 타입이 있는 함수의 경우) -> 값처럼 사용하면 됨
func sayHello(name: String) -> String {
    return "I'm \(name)"
}

"I'm 브라운" == sayHello(name: "브라운")

// 중첩 사용 : 함수 내부에서 함수 작성 가능 -> 당연한 내용
/*:함수 표기법(지칭), 함수의 타입 표기*/
// 정의문
func doSomething() {
    print("출력")
}

//실행문
doSomething()

//표기법(지칭) -> 언제쓰나요? 1. 공식문서에서 함수 지칭할 때 , 2. 함수를 변수에 담을 때
doSomething

// 예시
// do1의 타입 Void -> 값이 Void 니까
var do1 = doSomething()
//do1

// do2의 타입 () -> () 함수가 저장됨
var do2 = doSomething
//do2()

// 함수 표기법의 종류
// 1. 파라미터가 없는 경우
func funcOne() {
    print("one")
}
// 지칭만 한거임, 호출은 안함
funcOne

// 2. 파라미터가 있는 경우
func funcTwo(name:String) {
    print("two")
}
funcTwo(name:)

// 3. 파라미터가 여러개인 경우
func funcThree(name: String, age: Int) {
    print("three")
}
funcThree(name:age:)

// 4. 아규먼트 레이블이 없는 경우
func funcFour(_ name: String) {
    print("four")
}
funcFour(_:)

// 함수 타입의 표기 : (파라미터의 타입) -> 리턴타입

/*:함수의 오버로딩(overloading)*/
// 오버로드 : 과적하다
// 오버로딩 : 하나의 함수이름에 파라미터수/ 타입 , 아규먼트레이블, 리턴타입을 달리해서 계속 찍어낼 수 있다

/*:범위(Scope)*/
// 알고 있는 내용들
/*:제어전송문 정리*/
/*
 1. break : switch의 case에서 실행하는게 없을 때, 반복문 탈출할 때
 2. fallthrough : switch 폭포
 3. continue : 반복문 다음 싸이클로~
 4. return : 함수에서 값 리턴하거나, 함수 중지시킬 때
 5. throw : throw 뒤에 정의된 에러의 타입을 던지면서 함수 중지, 벗어남
 */
