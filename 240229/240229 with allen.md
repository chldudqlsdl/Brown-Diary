# 1) 스위프트의 정수타입 / 숫자 리터럴 (207강)

### 숫자 리터럴

```swift
//스위프트의    숫자 리터럴을 표기
var num: Int = 25

// 2진법/8진법/16진법
num = 0b00011001
num = 0o31
num = 0x19

// 큰숫자는 읽기 쉽게하기위해 언더바를 붙이는 것도 가능(언더바 기호를 읽지 않음)
num = 1_000_000
num = 10_000_000
num = 10000_0000
```

### 정수 타입

- `Int` `UInt`(양의정수) → 최근 대부분 64-bit (8bytes)
- 8-bit : Int8, UInt8
- 16-bit : Int16, UInt16
- 32-bit : Int32, UInt32
- 64-bit : Int64, UInt64

# 2) 오버플로우의 개념과 오버플로우 연산자 (208강)

### 개념

- C언어나 objc-C 에서는 산술연산자의 값의 넘침(오버플로우)을 허락함
    - 8 bit 숫자에서 255를 넘는 값을 담으면 다시 0으로 순환
- **Swift 는 이러한 오버플로우를 허락하지 않고 바로 크래시**
    - 이 오버플로우를 가능하게 하는 것이 오버플로우 연산자 → 크래시가 안남!

### 오버플로우 연산자

```swift
var a = UInt8.max  // 현재 변수 a에 UInt8타입의 최대값이 들어있음(255)
a = a &+ 1         // 오버플로우 더하기 연산자로 1을 더하기 ==========> 최소값(0)으로 이동

var a1 = Int8.max   // 현재 변수 a1에 Int8타입의 최대값이 들어있음(127)
a1 = a1 &+ 1        // 오버플로우 더하기 연산자로 1을 더하기 ==========> 최소값(-128)으로 이동
```

# 3) 논리연산자와 단락평가 (209강)

### 단락평가 : 결과 도출에 필요한 최소한의 논리식만 평가

- `true || false` 에서 왼편이 이미 true 이기에 오른편을 평가하지 않음
- `false && true` 에서 왼편이 이미 false 이기에 오른편을 평가하지 않음

### 주의사항

- Side-Effect
    
    ```swift
    var num = 0
    
    func checking() -> Bool {
        print(#function)
        num += 1
        return true
    }
    
    // if문의 조건식에서 함수를 호출하는 경우
    
    if checking() || checking() {    // 왼편만 평가하므로 num 1
    }
    
    if checking() && checking() {    // 양쪽 다 평가하므로 num 2
    }
    ```
    
- 해결 : 미리 함수의 리턴값을 변수에 넣어놓기
    
    ```swift
    doorCheck = 0
    passwordCheck = 0
    
    let doorResult1 = doorCodeChecking()
    let passwordResult1 = passwordCodeChecking()
    ```
    
# 4) 비트연산자 (210강)

## 논리연산

### ~ : Bitwise Not Operator

```swift
let a1: UInt8 = 0b0000_1111    // 15
let b1 = ~a1  // 0b1111_0000   // 240
```

### & : Bitwise AND Operator

```swift
let a2: UInt8 = 0b1111_1100   // 252
let b2: UInt8 = 0b0011_1111   // 63
let c2 = a2 & b2  // 0b0011_1100      // 60
```

### | : Bitwise OR Operator

```swift
let a3: UInt8 = 0b1011_0010   // 178
let b3: UInt8 = 0b0101_1110   // 94
let c3 = a3 | b3  // 0b1111_1110      // 254
```

### ^ : Bitwise XOR Operator

```swift
let a4: UInt8 = 0b0001_0100    // 20
let b4: UInt8 = 0b0000_0101    // 5
let c4 = a4 ^ b4  // 0b0001_0001    // 17
```

## 이동연산

### << : Bitwise Left Shift Operator

```swift
let leftShiftBits: UInt8 = 4   // 0b0000_0100   //   4
leftShiftBits << 1             // 0b0000_1000   //   8 (곱하기 2)
leftShiftBits << 2             // 0b0001_0000   //  16 (곱하기 2^2승 => 곱하기 4)
leftShiftBits << 5             // 0b1000_0000   // 128 (곱하기 2^5승 => 곱하기 32)
```

### >> : Bitwise Right Shift Operator

```swift
let rightShiftBits: UInt8 = 32  // 0b0010_0000   //  32
rightShiftBits >> 1             // 0b0001_0000   //  16 (나누기 2)
rightShiftBits >> 2             // 0b0000_1000   //   8 (나누기 4)
rightShiftBits >> 5             // 0b0000_0001   //   1 (나누기 2^5승)
```

### 주의 : 부호가 있고 Right Shift

```swift
let shiftSignedBits: Int8 = -2   // 0b1111_1110   //  -2
shiftSignedBits >> 1             // 0b1111_1111   //  -1 (나누기 2) 몫
shiftSignedBits >> 2             // 0b1111_1111   //  -1 (나누기 4) 몫
shiftSignedBits >> 5             // 0b1111_1111   //  -1 (나누기 2^5승) 몫
```

# 5) 연산자 메서드의 직접 구현 (211강)

### 커스텀 타입에서 연산자 메서드 사용방법

```swift
// 원래 내부에 + 가 아래와 같이 정의되어 있다
// infix operator + : AdditionPrecedence 
// static func + (lhs: String, rhs: String) -> String

struct Vector2D {
    var x = 0.0
    var y = 0.0
}

extension Vector2D {
    static func + (lhs: Vector2D, rhs: Vector2D) -> Vector2D {
        return Vector2D(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }
}

// 전치 연산자 => prefix
extension Vector2D {
    static prefix func - (vector: Vector2D) -> Vector2D {
        return Vector2D(x: -vector.x, y: -vector.y)
    }
}

extension Vector2D {
    static func += (left: inout Vector2D, right: Vector2D) {
        left = left + right
    }
}
```

### 비교 연산자 구현

```swift
// 동일성 비교 연산자 -> Equatable 프로토콜만 채택하면, 자동 추가
// 열거형 : 연관값이 있으면서(없으면 원래부터 가능), 모든 연관값이 Equatable 준수하는 경우
// 구조체 : '저장속성'만 가지며, 저장속성의 타입이 Equatable 프로토콜을 준수하는 경우

extension Vector2D: Equatable {
   
}

// 크기 비교 연산자 -> Comparable 프로토콜 채택하고, 시키는 대로 메서드 추가

extension Vector2D: Equatable, Comparable {
    static func < (lhs: Vector2D, rhs: Vector2D) -> Bool {
        <#code#>
    }
}
```

# 6) 사용자 정의 연산자의 구현 (212강)

### 중위 연산자

```swift
// 우선 순위 그룹의 선언

precedencegroup MyPrecedence {            // higherThan 또는 lowerThan 둘중에 하나는 반드시 지정해야함
    higherThan: AdditionPrecedence        // ~보다 높은(higherThan): 지정하려는 그룹보다 순위가 낮은 그룹
    lowerThan: MultiplicationPrecedence   // ~보다 낮은(lowerThan): 지정하려는 그룹보다 순위가 높은 그룹
    associativity: left          // 결합성 ===> left / right / none
}

// 연산자 선언

infix operator +-: MyPrecedence

// 연산자 실제 정의

extension Vector2D {
    static func +- (left: Vector2D, right: Vector2D) -> Vector2D {
        return Vector2D(x: left.x + right.x, y: left.y - right.y)
    }
}
```

- 우선순위를 지정해주지 않으면 DefaultPrecedence
- 우선순위를 사용자 정의하지 않고 이미 있는 것을 택해도 된다
    - AdditionalPrecedence , MultiplicationPrecendence etc

### 전치 ∙ 후치 연산자

```swift
// 연산자 선언

prefix operator +++

// 연산자의 실제 정의

extension Vector2D {
    static prefix func +++ (vector: inout Vector2D) -> Vector2D {
        vector += vector   // 복합할당 연산자는 이미 구현되어있기 때문에 사용 가능
        return vector
    }
}
```

- 우선순위를 지정해줄 필요 없음

# 1) 주요 프로토콜 - Equatable (214강)

### Equatable 프로토콜의 개념

- == , != 비교 연산자 관련 프로토콜
- 요구사항
    
    ```swift
    static func == (lhs: Self, rhs: Self) -> Bool // 메서드 구현
    ```
    
- 스위프트에서 제공하는 기본 타입은 모두다 채택을 하고 있음
    - 그러면 뭘 배워? ⇒ 커스텀 타입에서 어떻게 채택시키나?

## Enum

### 원칙

```swift
enum SuperComputer: Equatable {
    case cpu(core: Int, ghz: Double)
    case ram(Int)
    case hardDisk(gb: Int)
}
```

- 구조체, 열거형의 경우 Equatable 프로토콜 채택시 모든 저장 속성(열거형은 모든 연관값)이
Equatable 프로토콜을 채택한 타입이라면 비교연산자 메서드 자동구현

### 예외 🐸

```swift
enum Direction {
    case east , west , south , north
}
```

- 연관값이 없다면(원시값 여부는 상관없음) Equatable 프로토콜을 채택하지 않아도 동일성 비교 가능

## 구조체

```swift
struct Dog {
    var name: String
    var age: Int
}

extension Dog: Equatable {
}
```

- 구조체, 열거형의 경우 Equatable 프로토콜 채택시 모든 저장 속성(열거형은 모든 연관값)이
Equatable 프로토콜을 채택한 타입이라면 비교연산자 메서드 자동구현

## 클래스

```swift
class Person {
    var name: String
    
    init(name: String, age: Int) {
        self.name = name
    }
}

extension Person: Equatable {
    static func ==(lhs: Person, rhs: Person) -> Bool {  // 특별한 이유가 없다면 모든 속성에 대해, 비교 구현
        return lhs.name == rhs.name
    }
}
```

- 클래스는 인스턴스 비교를 하는 항등연산자(===)가 존재하기 때문에 비교연산자(==) 구현방식에 대해
개발자에게 위임
- **Equatable 프로토콜 채택 후 메서드 직접 구현해 줘야함**
