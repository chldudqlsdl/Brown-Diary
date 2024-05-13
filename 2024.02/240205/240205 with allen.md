# 메서드의 메모리 구조의 이해 (94강)

**! 메서드는 근본적으로 함수와 동일하다 & 함수는 그저 명령어의 묶음이다**

**데이터 영역에서는 ‘코드 영역에 적힌 메서드의 명령어’ 의 주소값만 가진다 → 메모리 공간을 차지하지 않는다..?**

## 클래스의 메서드

```swift
class Dog {
    var name = "보리"
    
    func sit() {
        print("앉았습니다.")
    }
}
var bori = Dog()
bori.sit()
```

### 메모리구조

- **`var bori` 를 찾으러 스택으로 가요(힙 주소 값 get)**
- **실체인 인스턴스를 찾으러 힙으로 가요(붕어빵틀의 데이터 영역 주소 값 get)**
- **메서드의 메모리 주소 값을 찾으러 붕어빵틀의 데이터 영역으로 가요(메서드의 코드 영역 주소값 get)**
    - **코드 영역의 주소값만 가지지, 메모리 공간을 차지하지는 않는다**
- 코드영역으로 가서 메서드를 실행시킨다
- 스택에 함수 스택 프레임을 만들고, 다 사용하면 사라진다

### 왜 메서드는 힙에 저장을 하지 않나요?

- **힙에 생기는 모든 인스턴스마다 메서드 메모리 주소를 붙이는 건 메모리 공간 낭비잖아**
- 프로퍼티는 커스텀을 하니까 힙에다 각각 저장하지만, 메서드는 있는 걸 그대로 쓰니까 하나만 있으면 된다…?

## 구조체의 메서드

```swift
struct Bird {
    func fly() {
        print("날아갑니다.")
    }
}

var bird = Bird()
bird.fly()
```

- `bird.fly()` 가 있는 코드영역에서 `fly()` 의 메모리 주소를 가지고 있다
- 그래서 코드의 `fly(){code}` 가 정의된 부분에 바로 찾아갈 수 있다

**→ 구조체의 경우에는 함수 메모리 주소에 직접 접근**

**⇒ 구조체는 스택의 인스턴스 데이터를 파라미터로 활용해 함수를 실행하는 것과 완전히 동일**

# 2) 계산 속성 (95강)

### 개념

**항상 다른 저장 속성에 의한 결과로 계산해 나오는 방식의 메서드의 경우 속성처럼 만들 수 있다**

**속성의 형태를 가진 실질적 메서드 → 메모리 공간을 가지지 않는다!!!**

**메서드라서 저장 속성에 자유롭게 접근이 가능하다**

### 기본형태

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
var p = Person()
p.bmi // 23.43
p.bmi = 30 // 값 세팅
p.weight // 76.8
```

- **var 로 선언하고, 자료형까지 적어줘야 한다**
- `**p.bmi` → 값을 얻는다 , `p.bmi = 30` → 값을 세팅한다**
- get → 값을 얻는다 , set → 값을 세팅한다
- get 은 필수이고, set 은 선택
    - get 만 있는 경우 → read-only 계산속성이고 ⇒ get블록 생략 가능
- set 블록의 파라미터를 생략하고, `newValue` 로 대체 가능 (물론 직접 파라미터 설정도 가능)

### 커스텀

```swift
class Youtube {
    var subscibers : Int
    var wholeWatchingTime : Double
    
    var averageWatchingTime : Double {
        get {
            return wholeWatchingTime / Double(subscibers)
        }
        set {
            self.wholeWatchingTime = Double(subscibers) * newValue
        }
    }
    init(subscibers: Int, wholeWatchingTime: Double) {
        self.subscibers = subscibers
        self.wholeWatchingTime = wholeWatchingTime
    }
}

var brownYoutube = Youtube(subscibers: 1000, wholeWatchingTime: 140000)
brownYoutube.averageWatchingTime // 140
brownYoutube.averageWatchingTime = 10
brownYoutube.wholeWatchingTime // 10000
```

# 계산 속성 이해하기 / 메모리 구조 (96강)

### 계산속성을 왜 사용하나요

- **가독성**
    - **관련 있는 두가지 메서드 한번에 구현 가능**
    - **속성 이름으로 설정가능 하니 명확해 보임…?**
- **메모리**
    - **실질적 메소드이기 때문에 메모리 공간을 가지지 않음**

### 메모리 구조

**메소드에 접근하는 메모리 구조와 거의 유사함**

- 스택에 가서 변수 찾고 인스턴스 주소값 획득
- 인스턴스 찾아서 붕어빵 틀 주소값 획득
- 붕어빵틀에서 계산속성의 메모리주소를 얻을 수 있음
- 코드영역의 계산속성 찾아가서 명령어 실행
- 스택프레임 생기고 값 리턴하고 사라진다

# 3) 타입 속성 (97강)

### 개념

**타입 자체의 속성**

**모든 인스턴스의 보편 속성이나, 공유해야하는 속성에 활용**

`Type.property` 로 접근합니다

## 저장 타입 속성

### 기본형태

```swift
class Circle {
    
    // (저장) 타입 속성 (값이 항상 있어야 함)
    **static let pi: Double = 3.14**
    **static var count: Int = 0**   // 인스턴스를 (전체적으로)몇개를 찍어내는지 확인
    
    var radius: Double // 반지름
    
    var diameter: Double {     // 지름
        get {
            return radius * 2
        }
        set {
            radius = newValue / 2
        }
    }
    
    init(radius: Double) {
        self.radius = radius
        Circle.count += 1 // **Circle.count 인 것 주의!!!**
    } 
}
```

- `Circle().pi` → 요렇게 타입 속성에 접근
- `let` `var` 둘다 선언 가능
- **항상 초기값이 필요하다 → 생성자가 없잖아요**
- 인스턴스 내에서도 `Circle.count` 로 접근해야한다

### 메모리

- **인스턴스에 속하는게 아니라, 데이터 영역에 붕어빵틀과 함께 저장**
- 저장공간은 가지는 듯
- lazy(지연) 속성의 성격을 가짐, 속성에 접근하는 순간 초기화

# 4) 속성 감시자 (99강)

### 개념

**저장속성의 변화를 감시하고 알려주는 메서드**

이거 코드 직접 짜려면 어려움…

### 기본형태

```swift
class Profile {
    var statusMessage: String = "기본 상태메세지" {
        willSet(message) {
            print("메세지가 \(statusMessage)에서 \(message)로 변경될 예정입니다.")
        }
    }
}
```

- 저장속성 뒤에다가 중괄호 붙여서 연결시킨다고 생각하면 됨
- 값의 변화를 관찰해야하니 var 저장속성에 붙어야할거고
- willSet , didSet 중 한가지만 구현 하면 됨
- 파라미터 생략하면 → new / oldValue
- 추가 가능한 경우
    - 저장속성
    - 상속한 계산 속성
