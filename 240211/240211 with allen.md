
# 1) 프로토콜의 개념 (125강)

### 왜 필요한가요? → 클래스 상속의 한계

1. **하나의 클래스만 상속 가능**
2. **상위 클래스를 따라야함 → 필요없는 저장 속성이나 메서드도 떠안아야 함**
3. **클래스(참조타입) 에서만 가능**

### 클래스 상속의 한계 예시

```swift
class Bird {
    
    func fly() {
        print("새가 하늘로 날아간다.")
    }
}

class Penguin: Bird {
    // fly()       // 상속 구조에서는 펭귄이 어쩔 수 없이 날개됨 ⭐️
    
    func swim() {
        print("헤엄친다.")
    }
}
```

→ 원치 않는 메서드를 떠안고 있는 상황

### 프로토콜!

```swift
protocol CanFly {
    func fly()      // 구체적인 구현은 하지 않음 ===> 구체적인 구현은 자격증을 채택한 곳에서
}

struct Airplane1: CanFly {  // 구조체에서도 채택가능
    func fly() {    
        print("비행기가 날아간다") // 구체적인 구현
    }
}
```

→ 구체적인 구현은 프로토콜을 채택한 곳에서 한다는 점이 특이하다

### 프로토콜은 타입으로 인식

```swift
struct FlyingMuseum1 {
    func flyingDemo(flyingObject: CanFly) {   // 중요한 기능 ===> 프로토콜을 타입으로 인식
        flyingObject.fly()
    }
}
```
# 2) 프로토콜 문법 (126강)

### 3단계 구현 : 정의 → 채택 → 구현

```swift
// 1) 정의
protocol MyProtocol {   // 최소한의 요구사항 나열
        func doing() -> Int
}

// 2) 채택 (클래스, 구조체, 열거형 다 가능)
class MyClass: FamilyClass, MyProtocol { 

// 3) (속성/메서드) 구체적인 구현
        func doing() -> Int {
                return 7
        }
}
```

- 상속이 있는 경우에는 슈퍼클래스 → 프로토콜 순서로

### 관습적으로 프로토콜은 익스텐션에서 채택과 구현하는 것을 권장

## 속성의 요구사항

### 인스턴스 속성

```swift
protocol RemoteMouse {
    
    var id: String { get }         
    
    var name: String { get set }       
        
        static var type: String { get set }
}
```

`{ get }` : 최소 요구사항이 읽기

- 저장속성 : var ∙ let(쓰기 안하겠다는 뜻)
- 계산속성 : get ∙ get/set

`{ get set }` : 최소 요구사항이 읽기, 쓰기 → **얘가 더 엄격하다**

- 저장속성 : var (let 을 사용하면 conform 에러)
- 계산속성 : get/set

### 타입 속성

```swift
class Ipad: RemoteMouse {
    var id: String = "777"
    
    var name: String = "아이패드"
    
    class var type: String {       // 타입 계산 속성은 재정의 가능 (class키워드 가능)
        get { "리모콘" }
        set { }
    }
}
```

- 기본 개념은 인스턴스 속성과 동일
- 타입저장속성은 상속은 되지만, 재정의가 불가하다. **타입계산속성(메서드니까)은 상속도 되고, 재정의도 가능하다**
    - **‘구현시’ static 키워드가 아니라 class 키워드를 사용해야한다**
    - 예시
        
        ```swift
        protocol MyProtocol {
            static var me : String { get }
        }
        
        class Test : MyProtocol {
            class var me : String {
                get { return "brown" }
                set {}
            }
        }
        
        class BabyTest : Test {
            override class var me: String {
                get { return "brown2" }
                set {}
            }
        }
        
        Test.me
        BabyTest.me
        ```
        
# 타입으로써의 프로토콜 (130강)

<aside>
💡 **프로토콜은 타입이다 → 일급객체**

</aside>

### 타입?

1. 프로토콜을 변수에 할당할 수 있음
2. 프로토콜을 파라미터로 전달할 수 있음
3. 함수에서 프로토콜을 리턴할 수 있음

### 기본형태

```swift
protocol Remote {
    func turnOn()
    func turnOff()
}

class TV: Remote {
    func turnOn() {
        print("TV켜기")
    }
    func turnOff() {
        print("TV끄기")
    }
    func doNetflix() {
        print("넷플릭스 하기")
    }
}

var tv : Remote = TV() // 이게 가능해지는 거다!
//tv.doNetflix()       // Remote 타입이어서 클래스에서 새롭게 정의한 메서드는 사용불가
```

## 프로토콜 준수성 검사 : is ∙ as

### is

```swift
// 특정타입이 프로토콜을 채택하고 있는지 확인
tv is Remote
sbox is Remote

// 프로토콜 타입으로 저장된 인스턴스가 더 구체적인 타입인지 확인 가능
let electronic: [Remote] = [tv, sbox]
electronic[0] is TV
electronic[1] is SetTopBox
```

### as

```swift
// 업캐스팅(as)
let newTV = tv as Remote
newTV.turnOn()
newTV.turnOff()

// 다운캐스팅(as?/as!)
let tv2: SetTopBox? = newTV as? SetTopBox
tv?.doNetflix()
```

### 장점?

- (클래스가 달라도)프로토콜 타입끼리 담아 놓을 수 있다
    
    ```swift
    let electronic: [Remote] = [tv, sbox]
    ```
    
- 프로토콜을 파라미터로
    
    ```swift
    func turnOnSomeElectronics(item: Remote) {
        item.turnOn()
    }
    ```
    
# 프로토콜의 선택적 요구사항의 구현 (132강)

## @어트리뷰트 키워드

### 선언에 추가정보 제공

```swift
@available(iOS 10.0, macOS 10.12, *)
class SomeType {      // "SomeType" 선언은 iOS 10.0 버전이상에서만 읽을 수 있음
}
```

### 타입에 추가정보 제공

```swift
func doSomething(completion: @escaping () -> ()){
}
```

## 선택적 요구사항의 구현

```swift
@objc protocol Remote {
    @objc optional var isOn: Bool { get set }
    func turnOn()
    func turnOff()
    @objc optional func doNeflix()
}
```

- 반드시 구현하지는 않아도 되는 멤버들
- 프로토콜 선언 앞에 붙이고, 멤버 선언 앞에 붙이고 두번 붙여준다
- 클래스 전용이라서, 구조체 열거형에서는 못 사용함
