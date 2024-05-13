# 6) escaping / autoclosure 키워드 (149강)

### @escaping 사용하는 케이스 두가지

- **클로저를 외부 변수에 저장하는 경우**
- **GCD(Grand Central Dispatch) 비동기 코드**

### 클로저를 외부 변수에 저장

```swift
var aSavedFunction: () -> () = { print("출력") }

func performEscaping2(closure: @escaping () -> ()) {
    aSavedFunction = closure         // 클로저를 실행하는 것이 아니라  aSavedFunction 변수에 저장
}

performEscaping2(closure: { print("다르게 출력") })
```

→ 안 적어주면 에러메시지

### 적어줘야 하는 이유

**클로저를 외부 변수에 할당하면, 오래 사용하기 위해서 클로저가 힙 영역에 저장된다**

**외부변수에 할당하지 않으면, 함수(클로저)는 스택프레임에 있다가 사라진다**

### GCD 비동기 코드

```swift
func performEscaping1(closure: @escaping (String) -> ()) {
    
    var name = "홍길동"
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {   //1초뒤에 실행하도록 만들기
        closure(name)
    }
}
```

**→ 1초 뒤에 실행시킨 다는 것은 함수를 기존의 스택프레임 만드는 흐름에서 빼와야 하기 때문에 @escaping**

### @autoclosure

```swift
func someFuction(closure: @autoclosure () -> Bool) {
    if closure() {
        print("참입니다.")
    } else {
        print("거짓입니다.")
    }
}

someFuction(closure: num == 1)
```

→ 인수 넣을 때 바로 중괄호가 없는 클로저 형태로 집어 넣게 해주는

# 1) 고차 함수 - map (150강)

<aside>
💡 **고차함수(고차원 함수)
→ 함수를 파라미터로 사용하거나, 함수 실행의 결과를 함수로 리턴하는 함수**

</aside>

### 몇가지 정보

- 대표주자 : map ∙ filter ∙ reduce
- 컬렉션에 기본 구현 되어 있다
- 함수형 언어에서 널리 사용된다
- 구현부의 파라미터 이름에 의미가 담겨 있네..(transform, isIncluded)

### map

```swift
let numbers = [1, 2, 3, 4, 5]

map<T>(_ transform: (Element) throws -> T) rethrows -> [T] // 구현부

numbers.map(transform: (Int) throws -> T) // 실행문

var newNumbers = numbers.map { (num) in
    return "숫자: \(num)"
}

newNumbers = numbers.map { "숫자: \($0)" }
```

- **기존 배열의 아이템을 새롭게 매핑해서 새로운 배열을 리턴하는 함수**
    - 매핑방식은 클로저가 제공
- for문 사용하는 것 보다 훨씬 고차원이긴 하다…
    - 보통은 함수의 파라미터가 배열인데, 여기는 함수의 파라미터가 함수네…

# 1) 고차 함수 - filter / reduce (151강)

### filter

**기존 배열의 각 아이템을 클로저가 제공은 조건으로 확인 해, 참을 만족하는 아이템을 걸러내서 새로운 배열을 리턴**

```swift
let names = ["Apple", "Black", "Circle", "Dream", "Blue"]

func filter(_ isIncluded: (Element) throws -> Bool) rethrows -> [Element] //구현부

names.filter(isIncluded: (String) throws -> Bool) // 실행문

var newNames = names.filter { (name) -> Bool in
    return name.contains("B")
}

var newNames = names.filter{ $0.contains("B")}

//var newName2 = names.filter(isIncluded : { str in
//    str.contains("e")
//}) -> 이렇게 줄일 수 있을 줄 알았는데, 파라미터 이름을 아규먼트 이름을 못가지게 해 놔서 isIncluded 지워야 한다
```

### reduce

**기존의 배열의 각 아이템을 클로저가 제공하는 방식으로 결합해서, 마지막 결과값을 리턴**

initialResult(초기값), 초기값과 배열을 순회하면서 빼온 값을 클로저가 시키는대로 가공해서 리턴 

그리고 그 값을 다시 다음 결과값에 넣고 가공을 반복하여 최종 결과값을 리턴

```swift
var numbersArray = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

func reduce<Result>(_ initialResult: Result, _ nextPartialResult: (Result, Element) throws -> Result) rethrows -> Result // 구현부

numbersArray.reduce(initialResult: Result) { Result, Int in // 실행문
    <#code#>
}

var resultSum = numbersArray.reduce(0) { (sum, num) in
    return sum + num
}

resultSum = numbersArray.reduce(0) { $0 + $1 }
```

### 크로스

```swift
numbersArray = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

// 위의 배열 중에, 홀수만 제곱해서, 그 숫자를 다 더한 값은?

var newResult = numbersArray
                        .filter { $0 % 2 != 0 }
                        .map { $0 * $0 }
                        .reduce(0) { $0 + $1 }
```

# 2) 고차함수 - forEach / compactMap / flatMap (152강)

### forEach

기존 배열 등의 각 아이템을 활용해서 각 아이템별로 특정 작업(작업 방식은 클로저가 제공)을 실행

**map이랑 비슷하지만, 얘는 리턴형이 Void 라서 배열을 리턴하지 않는다**

```swift
let immutableArray = [1, 2, 3, 4, 5]

immutableArray.forEach { num in
    print(num)
}

immutableArray.forEach { print("숫자: \($0)") }
```

### compactMap

기존 배열 등의 각 아이템을 새롭게 매핑해서(매핑방식은 클로저가 제공) 변형하되

옵셔널 요소는 제거하고, 새로운 배열을 리턴 → **옵셔널 바인딩 기능까지 내장**

```swift
let stringArray: [String?] = ["A", nil, "B", nil, "C"]

var newStringArray = stringArray.compactMap { $0 }

print(newStringArray) // ["A", "B", "C"]
```

### flatMap

중첩된 배열의 각 배열을 새롭게 매핑해서(매핑방식은 클로저가 제공) 내부 중첩된 배열을 제거하고 리턴

```swift
var nestedArray = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]

print(nestedArray.flatMap { $0 }) // [1, 2, 3, 4, 5, 6, 7, 8, 9]
```

# **스위프트의 프로그래밍 패러다임과 함수형 프로그래밍 (153강)**

<aside>
💡 **함수형 프로그래밍? → 기존의 함수를 어떻게 조합해서 구현할까?**

</aside>

### 비교

- 명령형 프로그래밍
    - 변수지정, for 문
    - **How** → 어떻게 구현해낼까?
- 함수형 프로그래밍 (선언형)
    - map, filter, reduce
    - **What** → 어떤 것(함수)들을 가져다 붙이면 결과가 나올까?

### 핵심

- **개발자는 중간과정을 신경쓰지 않고, 이미 정의된 함수를 가지고 어떻게 조합해서 결과를 만들어낼까? 만 신경쓰는 것**
- 간결한 코드 작성(SwiftUI)
- 비유 : 어떻게 산에 올라가는가?
    - 명령형 : 꼬불꼬불 걸어서 올라가기
    - 함수형 : 헬기를 타고 정상에서 내리기
