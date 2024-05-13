# 1) 주요 프로토콜 - Hashable (216강)

### 개념

- Dictionary ∙ Set 에서 Key 값으로 커스텀 타입을 사용하고 싶을 때 Hashable 사용
- 유일한 값으로 변환 가능한 타입인지를 묻는 것

### 열거형

- 연관값이 없다면
    - Hashable 프로토콜 없이도 유일성 판별 가능
- 연관값이 있다면
    - Hashable 프로토콜 채택해줘야 하는데 메서드는 자동 구현

### 구조체

```swift
struct Dog {
    var name: String
    var age: Int
}

extension Dog: Hashable {}
```

- 프로토콜 채택하고, 메서드는 자동구현

### 클래스

```swift
extension Person: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(age)
    }
    
    // == 연산자도 직접구현해야함
    static func == (lhs: Person, rhs: Person) -> Bool {
        return lhs.name == rhs.name && lhs.age == rhs.age
    }
}
```

- **프로토콜 채택하고, 메서드도 직접 구현해줘야 함**
    - Hashable 도 Equatable 을 상속하므로 == 도 구현해줘야함
    
# 2) CaseIterable 프로토콜 (217강)

### 개념

```swift
enum Color: CaseIterable {  // Int
    case red, green, blue
}

Color.allCases     // [Color.red, Color.green, Color.blue]
print(Color.allCases)
```

- Iterable : 반복가능한
- 프로토콜 채택하면 `static var allCases: Self.AllCases { get }` 위 타입 계산 속성이 자동 구현
- **모든 케이스를 (정의한 순서대로) 포함한 배열을 리턴**
- 연관값이 있으면 사용 불가

### 활용

```swift
// 손쉽게 반복문 사용 가능
for color in Color.allCases {
    print("\(color)")
}

// 필요로 하는 곳에서 선언도 간단하게
struct SomeView {
    let colors: [Color] = [Color.red, Color.green, Color.blue]
    //let colors = Color.allCases
}

// 공식문서의 예제

enum CompassDirection: CaseIterable {
    case north, south, east, west
}

// 1) 케이스의 갯수를 세기 편해짐 (케이스를 늘려도 코드 고칠 필요 없음)
print("방향은 \(CompassDirection.allCases.count)가지")

// 2) 배열 ===> 고차함수 이용 가능

let caseList = CompassDirection.allCases
                               .map({ "\($0)" })
                               .joined(separator: ", ")  // 배열 ===> 문자열화
// "north, south, east, west"

// 랜덤 케이스를 뽑아낼 수 있음

let randomValue = CompassDirection.allCases.randomElement()
```

# **4) 키패스(keyPath)와 셀렉터(selector) - 키패스 (219강)**

### 인스턴스에 접근하는 좀 더 쉬운 방법이 없을까? → keyPath

- 이러한 클래스가 있다면

```swift
// 생성자 생략
class School {
    var name: String
    var affiliate: SmallSchool
}

class SmallSchool {
    var classMember: Person
}

class Person {
    var name: String
}
```

- keyPath 표현식

```swift
let namePath = \School.affiliate.classMember.name   

school1[keyPath: namePath] 
```

→ 미리 경로를 지정해 놓는다!

- appending( )

```swift
let membetPath = \School.affiliate.classMember

let namePath = memberPath.appending(path:\.name)
```

→ 이런것도 가능
