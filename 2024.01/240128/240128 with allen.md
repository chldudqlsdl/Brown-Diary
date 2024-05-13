# 조건문 (switch문) (16강)

```swift
// 기본 형태
var age : Int = 30

switch age {
case 0...40 :
    print(true) 
    fallthrough
default :
    print(false)
}
```

### 흥미로운 사실들

- case 뒤의 값 자리에 콤마(,)로 여러 조건을 줄 수 있다 → ||(or) 의 의미
- 모든 케이스를 커버하지 못하는 경우에는 default 를 써줘야 한다
    - **아무것도 안 할거면 break 를 써줘야 한다**
- fallthrough 는 값에 관계 없이 다음 문장도 실행시켜준다
- **부등식 사용할 수 없고 → 범위 연산자 사용해야 한다**
    
    ```swift
    // 범위연산자 & 패턴매칭 연산자
    10...30 ~= age
    ```
    
    - 범위 연산자는 ~= 형태의 패턴매칭연산자로 참∙거짓 값을 도출한댄다
    - 범위연산자 : … 은 포함  ..< 은 안 포함
    
# switch문의 활용 (17강)

```swift
var score : Int = 50

switch score {
// % 가 == 보다 우선순위가 높다
case let x where x % 2 == 0 :
    print("짝수 입니다")
default :
    print("홀수 입니다")
}
```

바인딩 : 변수를 다른 상수∙변수의 식별자에 할당하는 것

< **Switch 문에서 조건을 사용하고 싶다면? >**

**변수를 상수 x 에 바인딩하고 where 조건절을 사용하여 조건 판별**

# 튜플 기본 (19강)

튜플 : **연관된 데이터의 조합**으로 어떤 형태든 만들 수 있는 타입

```swift
// 선언
var brown1 = ("브라운", 30, "포항")

// 값 접근
brown1.0
brown1.1
brown1.2

// 네임드 튜플
var brown2 = (name : "브라운", age: 30, location : "포항")
brown2.name
brown2.age
brown2.location

// 바인딩이 가능해요 -> 오 이거 신기하다
let(name, age, location) = ("브라운", 30, "포항")
print(name)
print(age)
print(location)
```

# 튜플의 활용 (20강)

### 튜플은 스위치랑 함께 사용되는 경우가 많다!

```swift
// 튜플과 switch 콜라보

var brown3 = ("브라운", 30)

switch brown3 {
case ("브라운", 10) :
    print("false")
case ("브라운", 30) :
    print("true")
default:
    break
}

// 튜플과 switch 바인딩 콜라보

switch brown3 {
case let(x,y):
    print("이름 : \(x) , 나이 : \(y)")
default:
    break
}

// 여기다 where 조건절도 추가가능하겠지!
switch brown3 {
case let(x, y) where y == 30 :
    print(true)
default :
    print(false)
}

// 마지막으로 신기한 것 -> 걸러낼 수 있다..!
switch brown3 {
case (let x , 10):
    print(false)
case (let x , 30):
    print(true)
default:
    print(false)
}
```

# 범위연산자 / 패턴매칭 연산자 (22강)

### 범위연산자

```swift
1...10 , 1..<10 , 1... , ...10
```

**특정한 조건에서만 사용해**

- switch 문에서 패턴 매칭
- for 문
- 배열의 서브스크립트?

유형

- 폐쇄 : … → 이상 ∙ 이하
- 반폐쇄 : ..<  → 미만

### 패턴 매칭 연산자

```swift
// true
1...10 ~= 5
```

오른쪽에 있는 표현식이 왼쪽의 범위에 포함되느냐에 따라 **참과 거짓을 리턴**

### 10 <= n <= 100 이런 문장은 스위프트에서 성립하지 않는다.

```swift
var n = 20

if n >= 10 && n <= 100 {
    print("10이상, 100이하입니다.")
}

if 10...100 ~= n {
    print("10이상, 100이하입니다.")
}
```
