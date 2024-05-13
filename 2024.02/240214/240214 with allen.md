# 1) 클로저의 개념 및 1급 객체 취급의 의미 (142강)

<aside>
💡 **중괄호가 나오면 함수(클로저)인 것을 인지하라
스위프트에서 함수는 타입(일급객체)이다**

</aside>

### 클로저의 개념

```swift
// 함수의 타입 표기법
let functionA: (String) -> String

// 기존 함수의 형태
func aFunction(str: String) -> String {
    return "Hello, \(str)"
}

// 클로저의 형태
let _ = {(str: String) -> String in
    return "Hello, \(str)"
}
```

- 클로저는 함수와 기능은 완전히 동일하며, 형태만 다르다 → 익명함수

### 중괄호!

```swift
let aClosureType = { () -> () in  // 변수에 담아서 호출하는 것도 가능
    print("안녕")
}

// 생략된 형태
let aClosureType = { print("안녕") }
```

**→ 생략이 되면 처음 봤을 때 무슨 의미인지 알기 매우 어려움.. 중괄호 나오면 아! 클로저구나 해야한다**

### 함수는 일급객체이다 → 함수를 변수에 저장할 수 있다

```swift
// 아니 이런게 가능했었어?
func aFunction1(param: String) -> String {
    return param + "!"
}

var a: (String) -> String = aFunction1

a("안녕")  // 함수는 이렇게 실행
```

**→ 파라미터 이름이 없는데도 괜찮다!?! ⇒ 이게 클로저에서 기본적으로 사용되는 형태인듯?**

### 연습 → 이런게 가능했었어…?

```swift
func love(name : String , mark: String) -> String {
    return "I love \(name + mark)"
}

let loveLetter = love   // 이렇게 함수 이름만 적으면 변수에 할당가능...

loveLetter("brown", "!")

let loveLetter = {(name : String , mark: String) -> String in
}

// 클로저로 표현하면 이런 형태
let loveLetter = {(name : String , mark: String) -> String in
    return "I love \(name + mark)"
}
```

# 4) 클로저의 문법 최적화 (146강)

### 최적화 과정

1. **파라미터, 리턴밸류 타입 추론**
2. **싱글 익스프레션(한줄 표현식)은 return 을 안 적어도 됨**
3. **아규먼트 이름 축약 ($0, $1)**
4. **트레일링 클로저 : 마지막 아규먼트가 클로저라면 소괄호 생략가능**

**→ 함수는 미리 정의되어 있고, 실행문에서 일어나는 일이니 자꾸 ‘아규먼트’ 라고 한다**

### 트레일링 클로저

```swift
// 1) (클로저를 파라미터로 받는 함수)정의
func closureParamFunction(closure: () -> Void) {
    print("프린트 시작")
    closure()
}

// 2) 함수를 실행할때 클로저 형태로 전달
// 함수의 마지막 전달 인자(아규먼트)로 클로저 전달되는 경우, 소괄호를 생략 가능
closureParamFunction(closure: {
    print("프린트 종료")
})

closureParamFunction(closure: ) {      // 소괄호를 앞으로 가져오기
    print("프린트 종료")
}

closureParamFunction() {               // 아규먼트 생략가능
    print("프린트 종료")
}

// 소괄호를 아예 생략할 수 있다.
// ==> 아래 형태가 함수를 실행하고 마지막 아규먼트로 클로저를 전달했다는 형태에 익숙해져야함
closureParamFunction {
    print("프린트 종료")
}
```

### 최적화 예시

```swift
// 함수의 정의
func performClosure(param: (String) -> Int) {
    param("Swift")
}

// 1) 타입 추론(Type Inference)
performClosure(param: { (str: String) in
    return str.count
})
performClosure(param: { str in
    return str.count
})

// 2) 한줄인 경우, 리턴을 안 적어도 됨(Implicit Return)
performClosure(param: { str in
    str.count
})

// 3) 아규먼트 이름을 축약(Shorthand Argements)
performClosure(param: {
    $0.count
})

// 4) 트레일링 클로저
performClosure(param: {
    $0.count
})
performClosure() {
    $0.count
}
performClosure { $0.count }
```

### 반대 예시

```swift
let closureType3 = { (a: Int, b:Int) -> Int in
    return a * b
}
```

- `-> Int` 이 부분 생략은 되지만(타입 추론 가능)
- `(a: Int, b:Int)` 이 부분의 타입이 생략되면 `a * b` 이 부분의 타입을 예측할 수 없어서 생략불가
