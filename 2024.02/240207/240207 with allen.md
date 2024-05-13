# 클래스의 상속과 재정의 (105강)

<aside>
💡 **저장속성 : 원칙적 불가, 계산속성으로는 가능, 속성감시자 추가가능
계산속성: 유지 / 확장하는 한에서 가능, 속성감시자 추가가능
메서드 : Free**

</aside>

### 속성과 메서드의 상속시 메모리 구조 복습

- 속성 : 상속시 서브클래스는 슈퍼클래스의 저장속성을 **참조**만 할 뿐, 그래서 **저장속성 추가만 가능**하다
- 메서드 : 메서드는 함수이고, 함수는 코드의 묶음이다. 클래스는 함수의 메모리 주솟값을 가지고 있는 것이다. 상속을 하면 서브클래스는 슈퍼클래스의 **메모리 주솟값 테이블을 새롭게 복사하여**? 가지고 온다. 이 과정에서 **메서드의 변형이나 추가를 자유롭게 할 수 있다**.

## 재정의(overriding)

### 개념

**서브클래스에서 슈퍼클래스의 동일한 멤버를 변형하여 구현하는 것**

### 기본형태

```swift
class Aclass {
    func doSomething() {
        print("Do something")
    }
}

class Bclass: Aclass {
    override func doSomething() {
        super.doSomething()
        print("Do another job")
    }
}
```

## 재정의 원칙

### 속성

- **저장속성은 재정의 불가**
    - 메서드형태로 추가하는 방식은 가능
        - **읽기 / 쓰기 가능한 계산속성 → 읽기만 추가하는 건 불가!!**
        - 속성 감시자 추가 가능
- **계산속성은 재정의 가능 → 기능을 유지 / 확장하는 범위에서** (읽기 → 읽기 / 쓰기)
    - 읽기 전용 → 속성 감시자 추가는 불가능(논리적으로 안 맞잖아)
- **속성 감시자 추가는 (가능한 경우에는) 언제나 가능!**
- 타입속성
    - class 키워드 붙은 계산 타입 속성은 가능

### 메서드

- 추가도 자유롭게 가능하고
- 슈퍼클래스의 메서드는 무시하고 새롭게 만드는 것도 가능
- 서브스크립트도 가능

### 연습

```swift
class Vehicle {
    var currentSpeed = 0.0
    
    var halfSpeed : Double {
        get {
            return self.currentSpeed / 2
        }
        set {
            self.currentSpeed = newValue
        }
    }
        func blowTheHorn() {
                print("meow")
            }
}

class Car : Vehicle {
        **// 저장속성 추가**
    var wheelCount = 4
    
        **// 저장속성을 계산속성으로 확장**
    override var currentSpeed : Double {
        get {
            return super.currentSpeed
        }
        set {
            super.currentSpeed = newValue
        }
    }
        **// 저장속성에 감시자 추가 (원래는 중복 재정의는 불가)**
        override var currentSpeed : Double {
        didSet {
            print("값이 \(oldValue) 에서 \(currentSpeed) 로 바뀌었습니다.")
        }
    }
        **// 계산속성 재정의**
        override var halfSpeed: Double {
            get {
                return super.halfSpeed / 3
            }
            set {
                super.halfSpeed = newValue * 3
            }
        }
        **// 저장속성에 감시자 추가 (원래는 중복 재정의는 불가)**
        override var halfSpeed: Double {
        didSet {
            print("\(oldValue) 에서 \(halfSpeed) 로 변경되었습니다")
        }
    }
        **// 메서드 재정의**
        override func blowTheHorn() {
        super.blowTheHorn()
        print("bow-wow")
    }
}
```
# 2) 초기화의 과정과 생성자 (107강)

### 초기화의 개념

**저장속성에 대한 초기값을 설정하여, 인스턴스를 사용가능한 상태로 만드는 것**

**생성자 : 초기화 메서드**

### 방법

1. **저장 속성의 선언과 동시에 값을 저장** → **자동생성**
2. **저장 속성 옵셔널** → **자동생성**
3. **생성자 사용하기**

### 기본형태

```swift
class Color {
    //let red, green, blue: Double // 동일한 타입일때, 한줄에 작성가능
    let red: Double
    let green: Double
    let blue: Double
    
    init(red: Double, green: Double, blue: Double) {
        self.red = red
        self.green = green
        self.blue = blue
    }

        init(white: Double) { // 오버로딩을 지원
        red   = white
        green = white
        blue  = white
    }
}
```

- 오버로딩을 지원한다 → 파라미터만 바꿔서 여러 생성자 만들 수 있음

### 생성자 직접 구현하지 않을 시

- 모든 저장 속성에 기본 값이 들어있다면
    - 클래스 → 기본 생성자 제공
    - 구조체 → 기본 생성자 제공 + 멤버와이즈 생성자(기본값 다 들어있으면 제공 안하는디..? → 뭔가 업데이트 된 듯)
- 일부 저장 속성에 기본 값이 들어있다면
    - 클래스 → 불가
    - 구조체 → 멤버 와이즈 생성자 제공
