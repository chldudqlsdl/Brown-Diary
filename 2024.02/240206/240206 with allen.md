# 1) 인스턴스 메서드 (100강)

### 개념

**우리가 아는 가장 기본 메서드**

### 기본형태 - 클래스

```swift
class Room {
    var size : Double = 2.0
    
    func sizeChange(_ size : Double) {
        self.size = size
    }
}
var room  = Room()
room.sizeChange(3.0)
```

- 메서드는 데이터영역에 존재하니, 메모리 공간이 할당되지 않는다

### 주의사항 - 착한 구조체의 반란

```swift
struct Hotel {
    var size : Double = 2.0
    
    **mutating** func sizeChange(_ size : Double) {
        self.size = size
    }
}
```

- **값타입은 인스턴스 메서드를 통해서 속성을 수정하는 건 불가**
    - **mutating** 키워드를 붙여주면 가능

### 오버로딩 가능 → 하나의 함수 이름에 여러개의 함수를 대응 시킨 것

```swift
class Room {
    var size : Double = 2.0
    
    func sizeChange(_ size : Double) {
        self.size = size
    }
    func sizeChange(_ isTrue : Bool) {
        if isTrue {
            self.size = 0.0
        }
    }
}
```
# 2) 타입 메서드 (101강)

### 개념

**인스턴스보다는 타입의 성격에 가까운 메서드**

### 기본형태

```swift
class Dog {
    static var species = "Dog"
    
    static func letmeKnow() {     // 타입 메서드에서, 타입속성에 접근시에는 타입으로 접근하지 않아도 됨
        print("종은 항상 \(species)입니다.")      // Dog.species라고 써도됨
    }
}

Int.random(in: 1...100) // 대표적인 예시
```

- **‘데이터’ 메모리 공간’ 은 없고, ‘주소값‘ 메모리 공간은 있다**
- 타입메서드에서 타입속성 접근시에는 속성이름만으로 접근 가능 (Type.species 할 필요없음)
- 상속시에도 사용하려면 static 대신에 class 키워드 사용

# 3) 서브스크립트 (102강)

### 개념

**메서드의 일종으로, [ ](대괄호)로 메서드를 실행시킨다**

### 기본형태

```swift
class SomeData {
    var datas = [1, 2, 3, 4, 5]
    
    subscript(index: Int) -> Int {
        get {
            return datas[index]
        }
        set(parameter) {
            datas[index] =  parameter
        }
    }
}
```

- 서브스크립트 키워드 적어주고, 파라미터(타입), 리턴타입 적어준다
- 메서드 → 메모리 공간 할당안됨(메모리 주소 공간은 할당)
- 계산속성과 유사
    - get 블록은 필수
    - newValue 사용하거나 위처럼 파라미터 이름 직접 사용

### 파라미터 2개 이상 사용하기

```swift
class Matrix {
    var data = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
    
    subscript(a: Int, b : Int) -> Int {
        return data[a][b]
    }
}
var matrix = Matrix()
matrix[1, 2]
```

### 열거형 + 타입서브스크립트

```swift
enum Planet : Int {
    case mercury, venus, earth, mars, jupiter
    
    static subscript(index : Int) -> Planet {
        return Planet(rawValue: index)!
    }
}

Planet[3] // .mars
```
# 접근 제어 / 싱글톤 패턴 (103강)

## 접근제어

### 개념

**은닉화 → 외부에서 접근불가**

### 기본형태

```swift
class Swift {
    private var property = "private property"
    
    func access() {
        self.property = "open property"
    }
}
var swift = Swift()
swift.access()
```

- `swift.property` 에 접근이 안된다
- 메서드를 통해서 접근(변경)은 가능 → 아이러니는 변경되었는지 안되었는지 확인도 못하네?
- 사용이유
    - 애플이 코드 숨기려고
    - 코드 영역을 분리시켜 효율적 관리
    - 컴파일 시간 절약

## 싱글톤 패턴

### 개념

**앱 구현시, 유일하게 한개만 존재하는 객체가 필요한 경우에 사용**

**한번 생성 후에는 앱이 종료될 때까지 유일한 객체로 메모리에 상주**

### 기본형태

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

- **자신의 객체를 생성해서, 전역 변수에 할당**
- Singleton.shared 를 여러개의 변수에 할당해도 다 값을 공유한다
- lazy 하게 동작 → 접근하는 순간 데이터 영역에 올라감
- `**private.init` → 유일한 객체를 만들려면 생성자를 잠궈야겠지?(필요에 따라)**

### 사용사례

```swift
let screen = UIScreen.main    // 화면
let userDefaults = UserDefaults.standard    // 한번생성된 후, 계속 메모리에 남음!!!
let application = UIApplication.shared   // 앱
let fileManager = FileManager.default    // 파일
let notification = NotificationCenter.default   // 노티피케이션(특정 상황, 시점을 알려줌)
```

# 1) 상속의 기본 개념 (104강)

### 개념

**성격이 비슷한 타입을 새로 만들어, 데이터(저장속성)를 추가하거나, 기능(메세드)를 변형시켜 사용하는 것**

### 기본형태

```swift
class AClass {
    var name = "이름"
}

class BClass: AClass {
    var id = 0 // name 저장속성도 사용가능!!
}
```

- 관계
    - 부모 / 자식 클래스 , 슈퍼 / 서브 클래스
- class 앞에 final 키워드를 붙이면, 더이상 상속 불가
- 재정의 하려면 override 키워드
- UIKit이 바로 클래스의 상속 구조로 만들어져 있다

### 메모리 TMI

- 저장속성
    - 서브클래싱을 하면 이전의 저장속성은 불변하고, 새로운 저장속성이 추가되는 형태
    - **서브클래스가 슈퍼클래스의 저장속성을 가지고 있는게 아니라(가리키고만 있다) 깰 수가 없다**
- 메서드
    - 메서드는 함수이고 함수는 코드의 모음이다
    - **서브클래싱하면 슈퍼클래스의 메서드의 함수 주솟값 테이블을 가져온다**
    - **재정의하면 새로운 주솟값이 테이블이 들어온다**
