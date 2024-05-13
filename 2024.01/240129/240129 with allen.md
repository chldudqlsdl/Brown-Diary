# 반복문 (for문) (23강)

### 기본형태 및 작동원리

```swift
var 범위 = 1...5

for item in 범위 {
    print("저는 반복문 입니다")
}
```

item : 중괄호 내부에서 사용할 **상수** 이름

범위 : 이 자리에는 **Range, 문자열, 컬렉션** 이 들어올 수 있어요

**작동원리 :** **범위에서 리터럴을 item 상수에 할당한뒤, 중괄호를 실행한다 → 범위만큼 순차 반복**

- 변수로 취급하고 싶으면 중괄호 내에서 다시 item 을 var 에 할당

### 와일드카드 패턴

```swift
var reapingTime = 3

for _ in 1...reapingTime {
    print("저는 \(reapingTime)번 대답합니다")
}
```

→ 상수를 중괄호 내에서 안 사용할거면 _ 를 사용하세요 ⇒ 주의 메시지 뜸

### 자주 사용하는 함수

```swift
// reversed()
for i in (1...10).reversed() {
    print("카운트다운 : \(i)")
}

// stride()
for i in stride(from: 2, to: 10, by: 2) {
    print("저는 짝수 \(i)입니다")
}
```

- reversed( ) : 범위를 역순으로 바꿔줍니다
    - 10…1 이런 범위는 선언불가
- stride( ) : 범위 징검다리
    - 두번째 파라미터 이름
        - to : 미만
        - through : 이하
        
# for문 사용시 주의점 (24강)

```swift
var name = "홍길동"

for name in 1...5 {
    print(name)
}
```

홍길동이 5번 찍히는게 아니라, 1,2,3,4,5 가 찍힘

Why? → for문에서 사용할 임시상수를 name 이라고 써줬고, 중괄호 내부에서는 가까운 변수를 따라간다

# while문 / repeat-while문 (25강)

### while 문

```swift
// 기본형태
var num = 2

while num < 6 {
    print("저는 \(num)살 유아입니다")
    num += 1
}
print("이제는 유아가 아닙니다")
```

→ 중괄호 안에는 조건에 변화를 주는 문장이 들어가야 무한루프가 안 일어나죠

### repeat-while 문

```swift
var cnt = 1

repeat {
    print("한번은 실수할 수 있어요")
    cnt += 1
} while cnt < 2
print("두번은 안 됩니다")
```

→ 문장을 실행하고 난 뒤에 조건 검증

# 반복문의 제어전송문 (continue / break) (26강)

### 제어전송문

**Control Transfer Statement => CPU의 제어장치를 제어한다는 뜻...?**

### continue, break

```swift
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
```

→ 중첩 사용할 때 주의하기~

### Labeled Statements

```swift
Outer : for i in 1...3 {
    Inner : for j in 1...3 {
        if j > 2 {
            continue Outer
        }
        print("i=\(i) , j=\(j)")
    }
}
```

→ 어떤 반복문을 continue or break 할지 지정할 수 있음!

# 함수의 기본 개념 (28강)

### 기본 형태 및 용어 정리

```swift
func introduce(name: String) -> String {
    return "저는 \(name)입니다"
}
introduce(name: "아이묭")
```

<aside>
💡 (name: String) : **파라미터, 매개변수, 인자**

"아이묭" : **아규먼트, 인수**

</aside>

name : 파라미터의 이름 , String : 파라미터의 타입 , -> String : 리턴 타입

**리턴타입 안 쓰면 에러나요**

### 표현식이 될 수 있다 (Void 와 비교)

# 함수의 응용 - 파라미터, 아규먼트 커스텀 (29강)

### 아규먼트 레이블

```swift
func inputYourName(성 lastname : String, 이름 firstname : String) {
    print(lastname + firstname)
}

inputYourName(성: "브", 이름: "라운")
```

### 파라미터 이름 생략 : _ (언더바)

```swift
func myPrint(_ word : String) {
    print(word)
}
myPrint("안녕하세요")
```

### 가변 파라미터 : 정해지지 않은 여러개의 파라미터를 받을 때

```swift
func averageMaker(_ numbers : Double...) {
    var total = 0.0
    for i in numbers {
        total += i
    }
    print(total / Double(numbers.count))
}
averageMaker(4.2 , 3.7 , 2.1)
```

### 파라미터 기본값 설정

# 함수 사용시 주의점 (30강)

### 파라미터는 상수이다

```swift
// 잘못된 문장
func func1(a : Int) {
    a = 2
    return a
}
```

a(파라미터)는 let(상수)이므로 값을 변경할 수 없다! 

### 함수의 실행문 : 함수를 호출하는 것은 그 자체로 표현식이다 → 값처럼 쓰면 됨

```swift
func sayHello(name: String) -> String {
    return "I'm \(name)"
}

"I'm 브라운" == sayHello(name: "브라운")
```

### 기타

- 함수내에서 선언한 변수는 내에서만 사용가능
- return 타입 없어도 return 사용가능 (사용하면 바로 함수 중지)
- 함수 내에서 함수 정의해서 사용가능        

# 함수의 표기법(지칭) / 함수의 타입 표기 (31강)

### 함수의 정의문, 실행문

```swift
// 정의문
func doSomething() {
    print("출력")
}

//실행문
doSomething()
```

### 함수의 표기법 언제 사용하나요?

- 함수 그 자체를 지칭할 때 (공식문서 or Xcode 자동완성)
- 함수 자체를 변수에 할당할 때

### 예시

```swift
// 이 경우 값이 저장되어 버림 : 변수타입 - Void
var do1 = doSomething()

// 함수가 변수에 저장됨 : 변수타입 - () -> ()
var do2 = doSomething

// 요렇게 하면 함수 실행!
do2()
```

### 경우의 수

```swift
// 1. 파라미터가 없는 경우
func funcOne() {
    print("one")
}
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
```

### 함수의 타입 표기

(파라미터 타입) → 리턴타입

### 문법적으로 함수 이름을 이야기해야할 때는 파라미터까지 말해야 함

# 제어전송문 정리 (34강)

### break

- switch : 케이스에 실행문장 없을 때 얘 쓰기로 약속
- 반복문 : 탈출

### fallthrough

- switch : 폭포처럼 다음 케이스로

### continue

- 반복문 : 다음 싸이클로~

### return

- 함수 : 결과가 있으면 결과값 리턴하면서 함수 중지, 없으면 그냥 중지

### throw

- 함수 : throw 다음에 적힌 에러타입 반환하면서 함수 중지
