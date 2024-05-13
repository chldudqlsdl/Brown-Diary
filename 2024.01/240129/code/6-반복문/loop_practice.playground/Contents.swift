import UIKit

/*: for 반복문
 */

// 기본형태

var 범위 = 1...5

for item in 범위 {
    print("저는 반복문 입니다")
}

// 와일드카드 패턴

var reapingTime = 3

for _ in 1...reapingTime {
    print("저는 \(reapingTime)번 대답합니다")
}

// 자주 사용하는 함수

// reversed()
for i in (1...10).reversed() {
    print("카운트다운 : \(i)")
}

// stride()
for i in stride(from: 2, to: 10, by: 2) {
    print("저는 짝수 \(i)입니다")
}

// 사용시 주의점 -> 홍길동이 5번 찍히는게 아니라, 1,2,3,4,5 가 찍힘.
// Why? => for문에서 사용할 임시상수를 name 이라고 써줬고, 중괄호 내부에서는 가까운 변수를 따라간다

var name = "홍길동"

for name in 1...5 {
    print(name)
}

/*: while문
 */

// while문 기본형태
var num = 2

while num < 6 {
    print("저는 \(num)살 유아입니다")
    num += 1
}
print("이제는 유아가 아닙니다")

// repeat-while 문 -> 최소 한번은 실행합니다

var cnt = 1

repeat {
    print("한번은 실수할 수 있어요")
    cnt += 1
} while cnt < 2
print("두번은 안 됩니다")

/*: 제어전송문
 */

// 제어전송문이 뭐에요? -> Control Transfer Statement => CPU의 제어장치를 제어한다는 뜻...?

// continue -> 반복문에서 다음 주기로 넘어가세요

for num in 1...10 {
    if num % 2 == 0 {
        continue
    }
    print("\(num)은 홀수입니다")
}

// break -> 반복문을 아예 break

for age in 1...10 {
    if age > 6 {
        break
    }
    print("저는 \(age)세 아기입니다")
}

// 중첩 사용시 주의해~

// Labeled Statements

Outer : for i in 1...3 {
    Inner : for j in 1...3 {
        if j > 2 {
            continue Outer
        }
        print("i=\(i) , j=\(j)")
    }
}


