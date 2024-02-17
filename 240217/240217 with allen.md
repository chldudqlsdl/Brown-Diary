
# ARC모델 (156강)

<aside>
💡 **ARC모델의 기반
소유정책 : 하나 이상의 소유자가 있으면 메모리에 유지
참조카운팅 : 나를 가르키는 소유자수를 카운팅**

</aside>

### MRC(Manual Reference Count)

```swift
class Dog {
        // var refCount: Int
    var name: String
    var weight: Double
    
}

var choco: Dog? = Dog(name: "초코", weight: 15.0)  
//retain(choco)   RC: 1
var bori: Dog? = Dog(name: "보리", weight: 10.0)   
//retain(bori)    RC: 1

choco = nil 
//release(choco)   RC: 0
bori = nil    
//release(bori)   RC: 0
```

- MRC 에서는 위 코드처럼 수동으로 RC 를 관리해줘야 한다
- 실수 가능성 높음
- **ARC 에서는 컴파일러가 메모리 관리 코드 자동 추가**

### ARC(Automatic Reference Count)

```swift
var dog1: Dog?
var dog2: Dog?
var dog3: Dog?

dog1 = Dog(name: "댕댕이", weight: 7.0)     // RC + 1   RC == 1
dog2 = dog1                               // RC + 1   RC == 2
dog3 = dog1                               // RC + 1   RC == 3

dog3?.name = "멍멍이"

dog3 = nil                                // RC - 1   RC == 2
dog2 = nil                                // RC - 1   RC == 1
dog1 = nil                                // RC - 1   RC == 0    // 메모리 해제
```

- **컴파일시에 메모리 해제시점을 결정한다**

# 2) 강한 참조 사이클과 메모리 누수 (157강)

<aside>
💡 **Weak Ref(약한참조) 사용시 참조하는 인스턴스가 사라지면 nil 을 자동으로 할당**

</aside>

### 강한 참조 사이클 → 메모리 누수

```swift
class Dog {
    var owner: Person?
}

class Person {
    var pet: Dog?
}

var bori: Dog? = Dog(name: "보리")
var gildong: Person? = Person(name: "홍길동")

bori?.owner = gildong
gildong?.pet = bori

bori = nil
gildong = nil
```

- 객체를 참조하면 참조 카운트가 증가함(참조를 하지 않으면, 카운트가 내려가고, 메모리에서 해제)
- **객체가 서로를 참조(강한참조가 default)하면 강한 참조 사이클 발생 → 변수에 nil 할당해도 서로 참조중인 객체의 카운트는 내려가지 않아 메모리에서 해제가 안된다(deinit 이 안 됨) ⇒ 이것이 메모리 누수**
- **둘 중에 한 녀석이라도 약한 참조면 사이클 발생 안 하는 듯?**

## 해결방법

### Weak Reference : 약한 참조

```swift
class Dog {
    weak var owner: Person?     // weak 키워드 ==> 약한 참조
}

class Person {
    weak var pet: Dog?         // weak 키워드 ==> 약한 참조
}

var bori: Dog? = Dog(name: "보리")
var gildong: Person? = Person(name: "홍길동")

// 강한 참조 사이클이 일어나지 않음
bori?.owner = gildong
gildong?.pet = bori

bori = nil
gildong = nil
```

- **가리키는 인스턴스의 RC 카운트를 올라가지 않게 한다**
- **가리키는 인스턴스가 사라지면 변수에 자동으로 nil 이 할당된다**

### Unowned Reference : 비소유 참조

```swift
class Dog1 {
    unowned var owner: Person1?   
}
```

- **가리키는 인스턴스의 RC 카운트를 올라가지 않게 한다**
- **가리키는 인스턴스가 사라졌는데 변수를 호출하면 nil 이 나오는게 아니라 Error…!**

### Weak. vs Unowned.

- 추천 상황(반려동물 예시)
    - Weak : 소유자에 비해 인스턴스가 생명주기가 짧을 때
    - Unowned : 소유자에 비해 인스턴스가 생명주기가 길거나 같을 때
- Unowned 에러 때문에 Weak 를 더 자주 사용하는 듯
- **까다로운 Weak → 인스턴스가 사라지면 nil 를 할당해야 하니까**
    - **let 사용불가**
    - **Optional 이 아닐 시 사용불가**

# 참조 타입 캡처와 캡처리스트 (159강)

### 참조 타입 캡처와 캡처리스트 개념

```swift
class SomeClass {
    var num = 0
}

var x = SomeClass()
var y = SomeClass()

let refTypeCapture = { [x] in
    print("참조 출력값(캡처리스트):", x.num, y.num)
}
```

- **y → `var y` 의 변수 주소를 캡처하고, `var y` 가 또 다시 `SomeClass()` 인스턴스 주소 참조 ⇒ 원쿠션**
- **X → 곧바로 `SomeClass()` 의 인스턴스 주소 복사 ⇒ 강하게 참조**
    - 아래 코드에서 7복사 하는 거랑 똑같은 구조
    
    ```swift
    num = 7
    
    let valueCaptureListClosure = { [num] in
        print("밸류값 출력(캡처리스트): \(num)")
    }
    ```
    
- **외부 요인에 의해 해당 인스턴스의 해제를 방지하는 용도로도 사용한다**

### 강한 참조 사이클 해결 → Weak ∙ Unowned

```swift
var z = SomeClass()

let refTypeCapture1 = { [weak z] in
    print("참조 출력값(캡처리스트):", z?.num)
}

let refTypeCapture2 = { [unowned z] in
    print("참조 출력값(캡처리스트):", z.num)
}
```

- 특이점 : `z?` (옵셔널)로 z 가 바뀌었는데 `var z` 의 타입은 그대로인 걸 보면 `var z` 는 `weak z` 에 바인딩 되면서 타입이 변경된 듯…?
- **Weak ∙ Unowned 써주면 클로저가 `SomeClass()` 를 약하게 참조(RC를 올라가지 않게)하여 강한 순환 참조를 방지할 수 있다**
- 바인딩도 가능
    
    ```swift
    var s = SomeClass()
    
    let captureBinding = { [z = s] in   // 내부에서 변수명 바꿔서 사용가능 (외부변수와 헷갈리는 것을 방지)
        print("바인딩의 경우:", z.num)
    }
    ```
    
# **일반적인 클로저의 사용 (객체 내에서 사용과 self키워드) (160강)**

### 일반적인 클로저의 사용

```swift
class Dog {
    var name = "초코"

    func doSomething() {
        DispatchQueue.global().async {
            print("나의 이름은 \(self.name)입니다.")
        }
    }
}

var choco = Dog()
choco.doSomething()
```

- `DispatchQueue.global().async` 는 2번 쓰레드에서 작업을 실행하라는 명령이다
- `**self.name`  클로저 내에서 객체의 속성 및 메서드 접근시에는 꼭 self 키워드 사용해야한다 ⇒ 강한참조**
    - 아래 코드랑 똑같은 의미입니다 → 강한참조임
    
    ```swift
    DispatchQueue.global().async { [self] in
                print("나의 이름은 \(name)입니다.")
            }
    ```
    
- 메인 쓰레드에서 클로저가 호출되면 힙 영역에 클로저를 저장하고, 2번 쓰레드에서 클로저를 실행한다
- **클로저가 실행 중인 동안 오랫동안 객체를 사용해야 하므로 객체(choco)를 클로저에서 주소를 보관한다 ⇒ 강한참조?**
- 클로저 실행 완료되면, 힙영역의 클로저도 제거됨

### 강한 참조 순환 해결 → 또 Weak ∙ Unowned

```swift
func sayMyName1() {
        DispatchQueue.global().async {
            print("나의 이름은 \(self.name)입니다.")
        }
    }
```

# 메모리 누수의 사례 (161강)

### 강한 참조 사이클로 인한 메모리 누수 : 클로저

```swift
class Dog {
    var name = "초코"
    
    var run: (() -> Void)?
    
    func saveClosure() {
        // 클로저를 인스턴스의 변수에 저장
        run = {
            print("\(self.name)가 뛴다.") // RC + 1
        }
    }
}

func doSomething() {
    let choco: Dog? = Dog()
    choco?.saveClosure()  // RC + 1 강한 참조사이클 일어남 (메모리 누수가 일어남)
}

doSomething()
```

- `doSomething()` 으로 실행하는 이유는 메모리 해제되는 것을 확인하려고!
- **객체인 `choco.run` 은 클로저를 가리키고 있고, 클로저는 choco를 강하게 참조해 메모리 주소를 가지고 있다 ⇒ 강한 순환 참조**
- 스택에서 choco 가 사라져도 둘은 서로를 가리키는 중

## 캡쳐리스트 실제 사용 예시

### 강한 참조의 경우

```swift
class ViewController: UIViewController {
    
    var name: String = "뷰컨"
    
    func doSomething() {
        DispatchQueue.global().async {
            sleep(3)
            print("글로벌큐에서 출력하기: \(self.name)")
        }
    }
    
    deinit {
        print("\(name) 메모리 해제")
    }
}

func localScopeFunction() {
    let vc = ViewController()
    vc.doSomething()
}                              // 이 함수는 이미 종료 ==> vc변수 없음

localScopeFunction()

// (3초후)
// 글로벌큐에서 출력하기: 뷰컨
// 뷰컨 메모리 해제
```

- vc 인스턴스가 생기고, vc 변수가 이를 참조하며 → RC 1
- 클로저가 힙에 생기며 이 인스턴스를 강하게 참조하며 RC 를 증가시킴 → RC2
- `sleep(3)` 동안 스택에서 vc 변수는 사라지기에 RC 감소 → RC 1
- 아직 RC가 남아있기에 힙에서 vc 인스턴스는 사라지지 않는다
- “글로벌큐에서 출력하기: 뷰컨” 이 출력되고 힙에서 클로저 해제되고 이후 vc 인스턴스도 해제됨

### 약한 참조의 경우

```swift
func doSomething() {
        // 강한 참조 사이클이 일어나지 않지만, 굳이 뷰컨트롤러를 길게 잡아둘 필요가 없다면
        // weak self로 선언
        DispatchQueue.global().async { [weak self] in
            //guard let weakSelf = self else { return }
            sleep(3)
            print("글로벌큐에서 출력하기: \(self?.name)")
        }
    }

// 뷰컨 메모리 해제
// (3초후)
// 글로벌큐에서 출력하기: nil
```

- vc 인스턴스가 생기고, vc 변수가 이를 참조하며 → RC 1
- 클로저가 힙에 생기는데 이 인스턴스를 약하게 참조하며 RC 를 증가시키지 않음 → RC1
- `sleep(3)` 동안 스택에서 vc 변수는 사라지기에 RC 감소 → RC 0
- RC가 없어지고 힙에서 vc 인스턴스는 사라진다 → “뷰컨 메모리 해제” 프린트
- vc 인스턴스가 없기에 3초후 “글로벌큐에서 출력하기: nil” 이게 출력이 된다
