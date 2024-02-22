# 제네릭 문법의 필요성 (183강)

### 왜 사용하나요? : 타입마다 함수를 다 따로 만들어야 한다

```swift
func printIntArray(array: [Int]) {
    for number in array {
        print(number)
    }
}

func printDoubleArray(array: [Double]) {
    for number in array {
        print(number)
    }
}
```

### 제네릭 함수의 정의

```swift
func swapTwoValues<T>(_ a: inout T, _ b: inout T) {
    let tempA = a
    a = b
    b = tempA
}

func printArray<T>(array: [T]) {
    for element in array {
        print(element)
    }
}
```

- <T> : 타입 파라미터의 지정 → 플레이스 홀더 역할(뭘 쓸지 알려주는)
- [T] : 타입 파라미터의 사용 → 호출시 실제 타입으로 치환

### 제네릭 함수 사용예시

```swift
var string1 = "hello"
var string2 = "world"

swapTwoValues(&string1, &string2) 

printArray(array: [1, 2, 3, 4]) 
```

# 제네릭 타입의 정의 (184강)

### 제네릭 타입의 정의 및 사용

```swift
// 구조체
struct GenericMember<T> {
    var members: [T] = []
}

var member1 = GenericMember(members: ["Jobs", "Cook", "Musk"])

// 클래스
class GridPoint<A> {
    var x: A
    var y: A
    
    init(x: A, y: A){
        self.x = x
        self.y = y
    }
}

// 열거형(연관값)
enum Pet<T> {
    case dog
    case cat
    case etc(T)
}

let animal = Pet.etc("고슴도치")
```

### 확장에 제네릭 적용

```swift
struct Coordinates<T> {
    var x: T
    var y: T
}

extension Coordinates {     // Coordinates<T> (X)
    
    func getPlace() -> (T, T) {
        return (x, y)
    }
}
```

→ 제네릭에는 플레이스 홀더 적어줄 필요 없다

### 확장으로 제네릭 제한

```swift
extension Coordinates where T == Int {     // Coordinates<T> (X)
    
    func getIntArray() -> [T] {
        return [x, y]
    }
}
```

→ T가 Int 타입이 아니면, 확장 메서드 사용불가

### 타입제약 : 프로토콜

```swift
func findIndex<T: Equatable>(item: T, array:[T]) -> Int? {     // <T: Equatable>
    for (index, value) in array.enumerated() {
        if item == value {
            return index
        }
    }
    return nil
}
```

→ `Equatable` 프로토콜을 상속한 타입으로만 사용가능하다!

### 타입제약 : 클래스

```swift
func personClassOnly<T: Person>(array: [T]) {
    // 함수의 내용 정의
}
```

→ Person 을 상속한 클래스만 사용가능

### 제네릭으로 선언된 함수에 타입을 구체적으로 명시하면, 구체적 타입을 가진 함수도 생긴다

# 프로토콜에서의 제네릭 문법의 사용 (185강)

### 프로토콜에서 제네릭 문법 정의와 사용

```swift
protocol RemoteControl {           // <T>의 방식이 아님
    associatedtype T               // 연관형식은 대문자로 시작해야함(UpperCamelcase)
    func changeChannel(to: T)      // 관습적으로 Element를 많이 사용
    func alert() -> T?
}

struct TV: RemoteControl {
    
    typealias T = Int       // 생략 가능
    
    func changeChannel(to: Int) {
        print("TV 채널바꿈: \(to)")
    }
    
    func alert() -> Int? {
        return 1
    }
}
```

- <T> 방식 쓰지 않고 → associated 방식
- 채택시에는 typealias → 생략 가능
- 프로토콜에서는 T 대신에 Element 를 사용함

### 프로토콜 제약 추가

```swift
protocol RemoteControl2 {
    associatedtype Element: Equatable     // <T: Equatable> 제약조건 추가
    func changeChannel(to: Element)
    func alert() -> Element?
}
```

# Result타입에 대한 이해 (186강)

<aside>
💡 **보다 진보된 형태의 에러처리 타입**

</aside>

## Result Type

### 구현

```swift
enum Result<Success, Failure> where Failure : Error {

    case success(Success)

    case failure(Failure)

}
```

- Success에 리턴값의 타입을 넣고, Failure 에 에러타입을 넣는다

### 참고 : 열거형 연관값???

```swift
// enum 연관값
enum Computer {
    case cpu(core: Int, ghz: Double)
}

var myChip1 = Computer.cpu(core: 8, ghz: 3.5)

// 연관값 제네릭으로 정의하기
enum Pet<T> {
    case dog
    case cat
    case etc(T)
}
```

### 사용

```swift
func resultTypeCheckingHeight(height: Int) -> Result<Bool, HeightError> {
    
    if height > 190 {
        return Result.failure(HeightError.maxHeight)
    } else {
        if height >= 160 {
            return Result.success(true)
        }
    }
}

// 리턴값을 받아서
let result = resultTypeCheckingHeight(height: 200)

// 처리
switch result {
case .success(let data):
    print("결과값은 \(data)입니다.")
case .failure(let error):
    print(error)
}
```

### 기존 방식 및 단점

```swift
func checkingHeight(height: Int) throws -> Bool {    // (에러를 던잘수 있는 함수 타입이다)
    
    if height > 190 {
        throw HeightError.maxHeight
    } else if height < 130 {
        throw HeightError.minHeight
    } else {
        if height >= 160 {
            return true
        } else {
            return false
        }
    }
}

do {
    let _ = try checkingHeight(height: 200)
    print("놀이기구 타는 것 가능")
} catch {
    print("놀이기구 타는 것 불가능")
}
```

- throw 키워드 필요하고, 에러 던질 때 throw 사용해야함
- try, do-catch 문 사용
- 에러 타입캐스팅 해줘야 함
