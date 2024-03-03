# 복습2

### 1-2) 지연 저장 속성 (Lazy) (92강)

- 기본형태
    
    ```swift
    struct Dog {
        var name : String
            // 생성자에서 초기화를 하지 않으니까 기본값이 반드시 필요
        lazy var nickName : String = "MR.\(name)"
    }
    
    var dog = Dog(name: "Charlie")
    dog.nickName // 이 시점에 nickName 메모리 공간 생성
    ```
    
- 효과
    - 메모리 공간 절약 → **속성에 접근하면 메모리 공간 생성**
    - 지연저장 속성이 다른 속성을 활용해야 할 때 (위의 코드)

### 메서드의 메모리 구조의 이해 (94강)

- 클래스
    - 메서드 실행 명령 → 스택에서 변수 찾아서 → 변수의 메모리 주소를 가지고 인스턴스가 있는 힙으로 → 힙에서 클래스의 데이터 영역 메모리 주소를 얻어서 데이터 영역으로 → 메서드의 코드영역 메모리 주소 얻어서 코드영역으로 가서 메서드 실행 ⇒ **상속때문에 이런 복잡한 과정을 거친다**
    - **힙에 메서드를 저장을 하지 않는 이유는 속성은 커스텀을 하니 인스턴스마다 다르지만 메서드는 동일하니 인스턴스 마다 가지고 있는 것은 메모리 낭비**
- 구조체
    - **메서드 실행 명령을 하면 명령어가 메서드의 메모리 주소를 이미 가지고 있다(박혀있음) → 코드 정의 부분 바로 찾아가서 실행 ⇒ 이게 원래 함수의 실행 방식과 동일(클래스가 특이한거)**

### 2) 계산 속성 (95강)

- 기본형태
    
    ```swift
    class Person {
        var height: Double = 160.0
        var weight: Double = 60.0
        var bmi: Double {
            get {
                let bmi = weight / (height * height) * 10000
                return bmi
            }
            set {
                self.weight = newValue * (height * height) / 10000
            }
        }
    }
    ```
    
- 특징
    - **속성의 형태를 가진 실질적 메서드 → 메서드처럼 데이터 영역에 올라간다! ⇒ 메서드와 메모리 사용 구조 동일**
    - get 은 필수 set 은 선택
    - set 블록 `newValue` 제공

### 3) 타입 속성 (97강)

- 기본형태
    
    ```swift
    class Circle {
        // (저장) 타입 속성 (값이 항상 있어야 함)
        **static let pi: Double = 3.14**
     
    }
    ```
    
- 특징
    - `Type.property` 로 접근
    - 항상 초기값이 필요하다 → 생성자가 없음
    - 데이터 영역에 저장 → 굳이 인스턴스에서 메모리 낭비할 필요 없음
    - lazy 성격 → 메모리에 접근 순간 초기화

### 4) 속성 감시자 (99강)

- 기본형태
    
    ```swift
    class Profile {
        var statusMessage: String = "기본 상태메세지" {
            willSet(message) {
                print("메세지가 \(statusMessage)에서 \(message)로 변경될 예정입니다.")
            }
        }
    }
    ```
    
- 특징
    - 저장속성 뒤에다 중괄호 붙이기
    - let 저장속성은 사용 불가
    - 계산속성도 사용불가 (상속하면 가능)

### 접근 제어 / 싱글톤 패턴 (103강)

- 기본형태
    
    ```swift
    class Singleton {
        static let shared = Singleton()
        
        var num = 100
        private init(num: Int = 100) {
            self.num = num
        }
    }
    let singleton = Singleton.shared
    ```
    
    - 생성자 접근제어도 가능(선택)
    - static let 사용
    - 메모리 누수 방지 효과

### 1) 상속의 기본 개념 (104강)

- **데이터(저장속성)를 추가하거나, 기능(메세드)를 변형**
    - 저장속성 - 서브클래스는 슈퍼클래스의 저장속성을 **가리키고만** 있기에, 변형은 불가
    - 메서드 - 서브클래스는 슈퍼클래스의 메서드 주솟값 테이블을 가진다, 변형 자유롭게

### 클래스의 상속과 재정의 (105강)

- 재정의
    - 속성
        - **저장속성 → 원칙적 불가 , 계산속성으로 재정의 가능**
        - **계산속성 → 기능 축소만 하지 않으면 재정의 가능**
    - 메서드
        - **생성자 → 재정의 필수**
        - **메서드 → 자유롭게 재정의**

### 2) 초기화의 과정과 생성자 (107강)

- 멤버와이즈 생성자 : **구현 안해도 제공해주는 , 저장속성 설정 가능한 생성자**
- 원래는 개발자가 생성자를 만드는 경우가 디폴트
    - 구조체에서 커스텀 생성자 만들면 멤버와이즈 압수
- 개발자가 생성자를 안 만든다면?
    - 기본값이 다들어 있는 경우
        - 클래스 : 기본생성자 제공(기본값으로)
        - 구조체 : 기본생성자 + 멤버와이즈 생성자
    - 기본값이 일부 있거나 없는 경우
        - 클래스 : 생성자 직접 만들어야 함
        - 구조체 : 멤버와이즈 제공!!!

### 지정 생성자 / 편의 생성자 (109강)

- 구조체
    - 생성자가 다른 생성자를 호출할 수 있다
- 클래스
    - **생성자가 다른 생성자를 호출하려면 편의생성자여야 한다! → 동일한 클래스의 지정생성자만 호출가능**
        
        ![Untitled](https://prod-files-secure.s3.us-west-2.amazonaws.com/2aece44c-d396-4369-b805-dee520d724c2/012f0212-b338-4e80-a58f-80b664a4dfec/Untitled.png)
        
    - **편의생성자는 상속이 불가하다**

### 지정 생성자 / 편의 생성자 상속과 재정의 규칙 (110강) → 너무 집착하지 말 것

- 기본규칙
    - 서브클래스의 지정생성자는 슈퍼클래스의 지정생성자를 반드시 호출 or 슈퍼클래스 지정생성자 재정의
    - **해당클래스 저장속성 초기화 → 슈퍼클래스의 저장속성 초기화 → 커스텀 저장속성(값 바꾸기)**
    - 보통은 상속하지 않고 재정의 한다
- 재정의 규칙
    - 지정생성자 : 재정의가능 → 지정생성자, 편의생성자
    - 편의생성자 : 재정의 불가
- 예외상황
    - 지정생성자 : 저장속성 기본값 설정 및 재정의 안했을 때
    - 편의생성자 : 상위 지정생성자를 모두 상속하거나 재정의 한 경우

### as연산자 / 다운캐스팅의 정확한 의미에 대한 이해 (116강)

- 업캐스팅은 as 고 다운캐스팅은 as?  로 정해진게 아니라, 업캐스팅은 실패가능성이 없으니 as 만 써도 되고, 다운캐스팅은 실패가능성이 있으니 as? 로 쓰는 것 같다..
- 업캐스팅 : as → 무조건 성공
    
    ```swift
    class Person {
        var id = 1
    }
    
    class Student : Person {
        var studentId = 10
    }
    
    var preStudent = student as Person
    ```
    
- 다운캐스팅 : as? ∙  as! → 실패가능성
    
    ```swift
    if let specialPerson = specialPerson as? Student {
        specialPerson.studentId
    }
    ```
    
    - 성공하면 옵셔널 , 실패하면 nil

### Any와 AnyObject를 위한 타입 캐스팅 (118강)

- 원래의 타입으로 사용하려면 다운캐스팅을 해야한다

### 확장의 개념 (119강)

- **현재 존재하는 타입에 기능(메서드)을 추가하여 사용하려는 것**
    - 메서드 및 계산속성
    - 생성자 (클래스는 편의생성자만)
- **상속은 되지만, 재정의는 불가하다 → Direct Dispatch 이기 때문에(구조체처럼)**

### 생성자의 확장 (122강)

- 클래스는 편의생성자만 → 상속과 관련되어 있기 때문에
- 구조체는 자유롭게

### 1) 프로토콜의 개념 (125강)

- 상속의 한계 타파
    - 필요한 저장속성이나 메서드만 사용하겠다!

### 2) 프로토콜 문법 (126강)

```swift
protocol RemoteMouse {
        // 속성
    var id: String { get }         
    var name: String { get set }       
        static var type: String { get set }

        // 메서드, 생성자
        static func reset()    
    func random() -> Int
        init()
}
```

**→ 계산타입속성 재정의 하고 싶으면 채택시에 class 키워드 붙이기**

**→ 생성자 채택시, required 붙여야 함(드물게 사용)**

### 타입으로써의 프로토콜 (130강)

- 프로토콜이 타입이 될 수 있다
    
    ```swift
    protocol Remote {
        func turnOn()
    
    }
    
    class TV: Remote {
        func turnOn() {
            print("TV켜기")
        }
    }
    
    var tv : Remote = TV() // 이게 가능해지는 거다!
    ```
    
- 장점
    
    ```swift
    //(클래스가 달라도)프로토콜 타입끼리 담아 놓을 수 있다
    let electronic: [Remote] = [tv, sbox]
    
    //프로토콜을 파라미터로
    func turnOnSomeElectronics(item: Remote) {
        item.turnOn()
    }
    ```
    

### 프로토콜의 선택적 요구사항의 구현 (132강)

- 예시
    
    ```swift
    @objc protocol Remote {
        @objc optional var isOn: Bool { get set }
        func turnOn()
        @objc optional func doNeflix()
    }
    ```
    

### 프로토콜의 확장 (133강)

- 기본값을 넣어주는 거랑 비슷
    
    ```swift
    protocol Remote {
        func turnOn()
        func turnOff()
    }
    
    extension Remote {                   
        func turnOn() { print("리모콘 켜기") }    
        func turnOff() { print("리모콘 끄기") }   
        func doAnotherAction() {            
            print("리모콘 또 다른 동작")          
        }
    }
    ```
    
- 프로토콜 지향 프로그래밍
    - `turnOn()` , `turnOff()` → Witness Table (데이터영역에 테이블이 생긴다)
    - `doAnotherAction()` → Direct Dispatch
    - 타입이 무엇이냐에 따라 속성, 메서드를 꺼내오는 저장위치가 다르다 → VirtualTable 과 WitnessTable을 동시에 가지고 있다가 타입에 따라 다르게 꺼내온다
        
        ```swift
        let ipad: Ipad = Ipad()
        ipad.turnOn()           // 클래스 - V테이블
        ipad.turnOff()          // 클래스 - V테이블
        ipad.doAnotherAction()  // 클래스 - V테이블
        
        let ipad2: Remote = Ipad()
        ipad2.turnOn()           // 프로토콜 - W테이블
        ipad2.turnOff()          // 프로토콜 - W테이블
        ipad2.doAnotherAction()  // 프로토콜 - Direct (직접 메서드 주소 삽입)
        ```
        
- 프로토콜 확장의 적용 제한
    
    ```swift
    extension Bluetooth where Self: Remote {  
        func blueOn() { print("블루투스 켜기") }
        func blueOff() { print("블루투스 끄기") }
    }
    ```
    
    → Remote 프로토콜을 채택한 타입만 Bluetooth의 **확장**을 지원하겠다!
    
    ### 메서드 디스패치 - 1 (136강)
    
    - **Direct Dispatch : 컴파일 시점에 코드에 함수의 메모리 주소 삽입**
    - **Table Dispatch : 함수의 포인터를 배열 형태로 보관 후 실행한다**
    - **타입에 따라 디스패치 방식이 바뀜**
        - **Value 타입(구조체) : 본체 - Direct , 확장 - Direct**
        - **Protocol : 본체 - Witness(Table) ,  확장 - Direct**
        - **Class : 본체 - Virtual(Table) , 확장 - Direct**
