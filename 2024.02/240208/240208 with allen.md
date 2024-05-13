# 생성자 (108강)

<aside>
💡 **일단 지정생성자(모든 저장속성을 초기화하는)를 만들고 시작해라 → 이후에 편의생성자로 땜질**

</aside>

## 구조체

### 지정생성자 → 모든 저장 속성을 초기화

```swift
struct Color1 {
    let red, green, blue: Double
    
    init() { 
        //red = 0.0 -> 올바르지 못한 방식
        //green = 0.0
        //blue = 0.0
        self.init(red: 0.0, green: 0.0, blue: 0.0)
    }
    
    init(red: Double, green: Double, blue: Double) {
        self.red   = red
        self.green = green
        self.blue  = blue
    }
}
```

- 구조체는 다른 생성자를 호출할 수 있다
- 위의 방식이 올바른 방식 → 중복이 없으니까

## 클래스

### 지정생성자와 편의생성자

```swift
class Color2 {
    let red, green, blue: Double
    
    convenience init() {
        self.init(red: 0.0, green: 0.0, blue: 0.0)
    }
    
    init(red: Double, green: Double, blue: Double) {
        self.red   = red
        self.green = green
        self.blue  = blue
    }
}
```

- 편의생성자가 지정생성자를 호출

### 편의생성자 사용예시 → 편의생성자는 상속이 되지 않는다

```swift
class Aclass {
    var x: Int
    var y: Int
    
    init(x: Int, y: Int) {    // 지정생성자 - 모든 저장 속성 설정
        self.x = x
        self.y = y
    }
    
    convenience init() {     // 편의생성자 - (조금 편리하게 생성) 모든 저장 속성을 설정하지 않음
        self.init(x: 0, y: 0)
    }
}

class Bclass: Aclass {
    
    var z: Int
    
    init(x: Int, y: Int, z: Int) {    // 실제 메모리에 초기화 되는 시점
        self.z = z                 // ⭐️ (필수)
        super.init(x: x, y: y)     // ⭐️ (필수) 상위의 지정생성자 호출
    }
    
    convenience init(z: Int) {
        self.init(x: 0, y: 0, z: z)
    }
    
    convenience init() {
        self.init(z: 0)
    }
}
```
# 지정 생성자 / 편의 생성자 (109강)

### 생성자 위임 규칙

1. 델리게이트 업 : **서브클래스의 지정생성자는 슈퍼클래스의 지정생성자를 반드시 호출해야 함**
2. 델리케이트 어크로스 : **편의생성자는 동일한 클래스 내에서 다른 생성자를 호출해야 함**

### 자세한 과정

```swift
class Bclass: Aclass {
    
    var z: Int
    
    init(x: Int, y: Int, z: Int) {    // 실제 메모리에 초기화 되는 시점
        self.z = z                 // ⭐️ (필수)
        super.init(x: x, y: y)     // ⭐️ (필수) 상위의 지정생성자 호출
    }
}
```

- **해당 클래스의 저장 속성 모두 초기화**
- **슈퍼 클래스의 저장 속성 모두 초기화**
- 이후에 저장 속성 커스텀 가능

# 지정 생성자 / 편의 생성자 상속과 재정의 규칙 (110강)

### 원칙

**생성자는 기본적으로 상속되지 않고 재정의 합니다**

### 방법

- **1단계**
    - **상위 지정 생성자 : 재정의 필수 고려**
        - **override 지정생성자**
        - **override 편의생성자**
        - **안함**
    - **상위 편의 생성자 : 재정의 불가**
- **2단계**
    - **현재 클래스의 모든 저장 속성 초기화 → 상위 지정 생성자 호출**
    - 순서도 중요하다

### 예시

```swift
// 지정생성자 재정의
class Vehicle {
    
    var numberOfWheels = 0
    
    var description: String {
        return "\(numberOfWheels) wheel(s)"
    }
}

class Bicycle: Vehicle {
    
    override init() {
        super.init()           
        numberOfWheels = 2      
    }
}
```

# 지정 생성자 / 편의 생성자 상속의 예외사항 (111강)

<aside>
💡 **경우의 수**

- **하위클래스에 저장속성이 없거나(있어도) 기본값이 설정 → 지정생성자, 편의생성자 전부 자동상속**
- **저장속성이 있고 기본값이 설정이 안됨 → 지정생성자가 자동상속이 안됨**
    - **재정의 해주면 편의생성자 상속 가능**
    - **재정의 안하면 편의생성자 상속 불가**
</aside>

### 지정생성자 자동상속

**하위클래스에 새 저장 속성이 없거나, 기본 값이 설정되어 있다면 → 실패가능성이 없으니까!**

### 편의생성자 자동상속

**모든 지정생성자를 상속하는 상황이 되면**

- 슈퍼클래스 지정생성자 모두 자동상속
- 슈퍼클래스 지정생성자 모두 재정의

# 필수(Required) 생성자 (112강)

### 개념

**클래스 생성자 앞에 required 키워드를 붙이면, 하위클래스에서 반드시 해당 생성자를 구현 해야한다**

하위 생성자에서 구현시 override 없이 required 만 붙이면 된다

**다른 지정 생성자 구현 안하면 자동 상속되고, 하면 직접 구현 해야함**

# 실패가능(Failable) 생성자 (113강)

<aside>
💡 **실패 가능 생성자는 실패 불가 생성자를 포함한다**

</aside>

### 개념 ⇒ 옵셔널 생성자

인스턴스 생성에 실패할 수도 있는 경우 → 리턴값은 옵셔널 타입

`init?()`  하면 됩니다 생성자에는 `→ Int?`  이런게 없기 때문

### 기본형태

```swift
struct Animal {
    let species: String
    
    init?(species: String) {
        if species.isEmpty {
            return nil            **// 생성자 내에서 실패 가능 부분에 nil을 리턴하면 됨**
        }
        self.species = species
    } 
}
```

- 실패가능 부분에 nil 을 리턴하면 되고
- 초기화 성공을 나타낼 때 return 을 쓰지는 않는다

### 호출관계

실패가능이 실패불가를 호출 할 수는 있지만, 그 반대는 불가능!

일반 리턴 타입인데, 옵셔널 타입이 리턴되면 안 되잖아!

### 재정의

상위가 실패가능이고, 하위가 실패불가 일 수는 있지만,

상위가 실패불가이고, 하위가 실패가능 일 수는 없다

→ 어차피 에러메시지가 못하게 막음… ㅎ
