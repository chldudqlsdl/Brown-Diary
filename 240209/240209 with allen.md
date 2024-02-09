# is연산자 (115강)

### 개념

**type check operator**

### 기본형태

```swift
person1 is Person                // true
person1 is Student               // false
person1 is Undergraduate         // false
```

- **어떤 인스턴스가, 어떤 클래스에 포함이 되냐? 를 묻는 것**

### 상세

- Person()
    - **var id , var name , var email**
- Student() : Person
    - **var id, var name, var email**, **var student id**
- 집합 관계로 생각하자
    - Student
        - Person
    - Student is Person → True
    - Persont is Student → False

# as연산자 / 다운캐스팅의 정확한 의미에 대한 이해 (116강)

### as 연산자의 개념

**클래스의 계층간의 타입을 변환하는 것**

## 기본형태

### 다운캐스팅 as? as! → 내려가는 것은 원래 하위 클래스인 경우에만 가능

```swift
// as?
var specialPerson: Person = Student() // 업캐스팅이다
var specialPerson = Student() as Person // 둘다 똑같은 의미이다

if let specialPerson = specialPerson as? Student {
    specialPerson.studentId
}

// as!
var newPerson = specialPerson as! Student
```

- 실패가능성이 있으니 `specialPerson as? Student`  는 Optional type 이어서 옵셔널 바인딩을 해줘야한다
- as! 로 강제 언래핑 해줄 수도 있다

### 업캐스팅 as → 위로 올라가는 것은 가지고 있는 것을 버리면 되니까 자유롭다

```swift
class Person {
    var id = 1
}

class Student : Person {
    var studentId = 10
}

var person = Person()
var student = Student()

var preStudent = student as Person
var preStudent : Person = Student()
```

**→ 맨 아래 처럼 업캐스팅은 두가지 방식으로 이루어질 수 있다**

### 작동원리

- `Student()`  를 선언하면 인스턴스가 힙에 저장된다
- `var person : Person`  에 할당해도 할당이 가능하다 → `Student()` 의 일부 저장속성만 참조하는 것
- 데이터영역의 Person 의 저장속성만 접근가능하다
- 메서드도 Person의 메서드만 접근가능하다
- 신기한 사실
    - Student에서 Person 의 메서드를 오버라이딩하면, person의 메서드에 접근했을 때 Student 의 오버라이딩 메서드가 사용된다 → 메서드는 참조를 안 하고 있으니 모르려나?

### as연산자 활용

Swift 타입과 Obj-c 타입간의 호환

`String as NSString`

# 상속과 다형성 (117강)

### 다형성이란?

OOP의 4대 특징

**하나의 객체가 여러가지의 타입으로 표현될 수 있다**

### 상속에서의 다형성? → 메서드

**업캐스팅된 타입의 메서드를 호출하더라도 실제 메모리에 구현된 재정의된 메서드가 호출되어 실행된다**

**타입의 저장 형태 → 속성 / 메서드에 대한 접근 가능 범위**

**다형성 → 인스턴스에서 메모리의 실제 구현**

### 예시

```swift
class Person {
        var name = "이름"
    
    func walk() {
        print("사람이 걷는다.")
    }
}

class Student: Person {
    
    override func walk() {         // 재정의 메서드
        print("학생이 걷는다.")
    }
}

let person = Student() as Person
person.walk() // "학생이 걷는다"
```

### 메모리구조

- Data 영역
    - Person()
        - 저장속성, 메서드1
    - Student()
        - 상속저장속성, 메서드2
- Heap 영역
    - Student() 인스턴스
        - **Person() 의 저장속성 참조**
        - **Student() 의 메서드2 참조 → Person()의 메서드1 과는 별개(접근못함)**
- Stack 영역
    - var person : Person = Student()
    
# Any와 AnyObject를 위한 타입 캐스팅 (118강)

### Any 타입

**어떤 타입의 인스턴스도 포함할 수 있는 타입**

### AnyObject 타입

어떤 **클래스 타입**의 인스턴스도 포함할 수 있는 타입

### 기본형태

```swift
// 장점 : 변수 some 에 어떤 타입이라도 할당할 수 있다

var some: Any = "Swift"

some = 10

// 단점 : 타입을 추론할 수 없기에, 타입 캐스팅을 해야한다

let array: [Any] = [5, "안녕", 3.5, Person()]

(array[1] as! String).count // 다운캐스팅을 해야 .count 를 쓸 수 있음
```

- 장점 : 변수 some 에 어떤 타입이라도 할당할 수 있다
- 단점 : 타입을 추론할 수 없기에, 타입 캐스팅을 해야한다
- Any → String 이 다운캐스팅 ⇒ 더 구체적인 타입으로 다운되니까

### Switch 문과의 조합

```swift
for (index, item) in array.enumerated() {
    
    switch item {
    case is Int:                                  // item is Int
        print("Index - \(index): 정수입니다.")
    case let num as Double:                       // let num = item as? Double
        print("Index - \(index): 소수 \(num)입니다.")
    default:
        print("Index - \(index): 그 이외의 타입입니다.")
    }
}
```

- `item is Int`  → `case is Int`
- `let num = item as? Double`  → `cae let num as Double`

# 확장의 개념 (119강)

### 개념

**현재 존재하는 타입에 기능(메서드)을 추가하여 사용하려는 것**

**상속은 되지만, 재정의는 불가하다**

### 장점

```swift
extension Int {
    var squared: Int {
        return self * self
    }
}
```

- 이런게 가능해진다(소급-모델링)

### 메모리구조

- Person()
    - 저장속성
    - 메소드A + **익스텐션 메소드**
- Student()
    - 저장속성
    - 메소드A’ + **익스텐션 메소드’**
- 실제로 기존의 메소드와는 따로 존재한다
- **상속은 되지만, 재정의는 불가하다**
    - 익스텐션 @objc 붙이면 재정의 가능(objc 는 메소드의 메모리 구조가 좀 다르다)

### 확장 가능 멤버 종류 → 메서드형태

- 계산 속성 (타입, 인스턴스)
- 메서드 (타입, 인스턴스)
- 새로운 생성자(클래스는 편의생성자만)
- 서브스크립트
- 새로운 중첩타입
- 프로토콜

# 생성자의 확장 (122강)

## 클래스 → 편의생성자만 추가 가능

```swift
extension UIColor {
    
    convenience init(color: CGFloat) { 
                // 본체에 존재하는 지정생성자
        self.init(red: color/255, green: color/255, blue: color/255, alpha: 1)
    }
}
```

## 구조체

### 지정생성자 추가 ∙ 본체 호출방식(클래스의 편의생성자) 둘다 가능!

```swift
struct Point {
    var x, y : Double
    
    init(x: Double, y: Double) {
        self.x = x
        self.y = y
    }
}

extension Point {
    init(num: Double) {
        self.init(x: num, y: num)
    }
}
```

ㅇ
