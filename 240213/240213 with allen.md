
# 중첩타입 (138강)

<aside>
💡 **중간 타입에 대문자가 나오면  중첩타입임을 인지**

</aside>

### 사용하는 이유

하나의 타입의 내부 구조(계층 관계 등)를 디테일하게 설계 가능

실제 앱을 만들때 중첩 선언을 잘 활용해야함 (타입 간의 관계 명확성)

중첩타입으로 선언된 API들을 볼줄 알아야함

### 선언

```swift
class Aclass {
        struct Bstruct {
        enum Cenum {
            case aCase   // 열거형에는 케이스 필요
            case bCase
            
            struct Dstruct {
                
            }
        }
        var name: Cenum
    }
}
```

### 애플 공식문서 예제 : 블랙잭

```swift
struct BlackjackCard {

    // Suit(세트) 열거형
    enum Suit: Character {     // 원시값(rawValue)사용
        case spades = "♠", hearts = "♡", diamonds = "♢", clubs = "♣"
    }

    // 순서(숫자) 열거형
    enum Rank: Int {     // 원시값(rawValue)사용
        case two = 2, three, four, five, six, seven, eight, nine, ten
        case jack, queen, king, ace   // (원시값 존재하지만 사용하지 않고자 함 ===> values)
        
        **// Values 타입정의 (두개의 값을 사용) //===> 열거형 값(순서)을 이용 새로운 타입을 반환하기 위함**
        struct Values {
            let first: Int, second: Int?
        }
        
        // (읽기) 계산 속성 (열거형 내부에 저장 속성은 선언 불가)
        var values: Values {
            switch self {
            case Rank.ace:
                return Values(first: 1, second: 11)    // 에이스 카드는 1 또는 11 로 쓰임
            case .jack, .queen, .king:
                return Values(first: 10, second: nil)  // 10으로 쓰임
            default:
                return Values(first: self.rawValue, second: nil)    // 2 ~ 10까지의 카드는 원시값으로 쓰임
            }
        }
    }
    
    // 블랙잭 카드 속성 / 메서드  =======================================
    // 어떤 카드도, 순서(숫자)와 세트(Suit)를 가짐
    let rank: Rank, suit: Suit
    
    // (읽기) 계산속성
    var description: String {
        get {
            var output = "\(suit.rawValue) 세트,"
            output += " 숫자 \(rank.values.first)"
            
            if let second = rank.values.second {   // 두번째 값이 있다면 (ace만 있음)
                output += " 또는 \(second)"
            }
            
            return output
        }
    }
}
// A - 스페이드

let card1 = BlackjackCard(rank: .ace, suit: .spades)
print("1번 카드: \(card1.description)")
```

- **구조체를 타입으로 활용하기 위해서, 바로 선언하는 장면이 인상깊다**

# self VS Self 비교 (141강)

### self

1. 인스턴스를 가리키기 위해

```swift
class Person {
    var name: String
    init(name: String) {
        self.name = name
    }
}
```

1. 새로운 값으로 속성 초기화 가능한 패턴 (값타입에서)

```swift
struct Calculator {
    var number: Int = 0
    
    mutating func plusNumber(_ num: Int) {
        number = number + num
    }
    
    // 값 타입(구조체, 열거형)에서 인스턴스 값 자체를 치환 가능
    mutating func reset() {
        self = Calculator()    // 값 타입은 새로 생성해서 치환하는 것도 가능
    }
}
```

1. **타입멤버에서 사용하면, 인스턴스가 아닌 타입 자체를 가르킴**

```swift
struct MyStruct {
    static let club = "iOS부서"
    
    static func doPrinting() {
        print("소속은 \(self.club)입니다.")
    }
}
```

1. 타입 인스턴스를 가르키는 경우에 사용 (외부에서 타입을 가르키는 경우)

```swift
class SomeClass {
    static let name = "SomeClass"
}

let myClass: SomeClass.Type = SomeClass.self
// SomeClass.Type ===> 메타타입 (후반부에 다룰 예정)
```

### Self

1. 타입내부에서 타입선언
2. 타입속성 / 메서드 지칭

```swift
extension Int {
    // 타입 저장 속성
    static let zero: Self = 7    // Int 타입
    
    // 인스턴스 계산속성
    var zero: Self {  // 1) 타입을 선언하는 위치에서 사용
        return 5
    }
    
    // 2) 타입 속성/메서드에서 지칭
    static func toZero() -> Self {
        return Self.zero      // Int.zero
    }
}
```

1. **프로토콜에서 채택하려는 타입을 지칭**

```swift
extension BinaryInteger {
    func squared() -> Self {  // 타입자체(Int)를 가르킴
        return self * self    // 인스턴스(7)를 가르킴
    }
}
```

