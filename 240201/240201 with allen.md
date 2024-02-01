# 딕셔너리 / 해셔블(Hashable) (49강)

### 기본형태

```swift
// 정석
var dic : Dictionary<String, String> = ["A": "Apple", "B": "Banana", "C": "City"]
// 단축 문법
var dic : [String: String] = ["A": "Apple", "B": "Banana", "C": "City"]
// 빈 사전 생성
let emptyDic1: Dictionary<Int, String> = [:]
let emptyDic2 = Dictionary<Int, String>()
let emptyDic3 = [Int: String]()
```

- 키값은 중복 불가능
- 타입을 잘 지켜야 하고
- **키값은 Hashable 해야함**

### Hashable

- Hashable → Hash 할 수 있다 ⇒ **Hash 함수의 Input 값으로 사용할 수 있다**
- 어떤 타입이 가능한가요? → Swift 기본 타입들은 다 됨(String, Int, Double…)
- Hash 함수가 무엇을 하나요? → **Input 값을 고유한 Hash값으로 바꾸어준다**
- 뭐가 좋은 건가요? → 배열보다 빠르다
    - **값의 유일성 보장** → Input 값은 고유한 Hash 값을 가지니깐
    - **검색 속도 빠름** → 하나하나 확인하는게 아니라 바로 찾아낼 수 있다

## 기능

### 기본

```swift
dic.count
dic.isEmpty
 // named tuple 형태로 리턴
dic.randomElement() // (key: "B", value: "Banana") 요렇게
```

### 요소 접근

```swift
**dic["A"] // 값이 없을 수 있기에 옵셔널**
dic["S", default: "Empty"] // 디폴트값 리턴하는...
```

### 키/ 값들

```swift
dic.keys // 배열로 리턴, 없으면 빈 배열
dic.values

dic.keys.sorted() // 배열은 소팅 할 수 있으니까, 해서 for문에 써도 되구
dic.values.sorted()
```

### 업데이트

배열의 삽입 ∙ 교체 ∙ 추가를 딕셔너리에서는 업데이트로 퉁침

딕셔너리는 순서가 없으니 당연히 append 도 없음

```swift
words = [:]

words["A"] = "Apple" // 해당 키 값이 없으면 추가, 있으면 교체
words.updateValue("City", forKey: "C") 
// 키 값이 있으면 교체된 밸류("city") 리턴, 없으면 nil 리턴
```

### 삭제

```swift
dic["B"] = nil    // 해당요소 삭제
dic["E"] = nil   // 존재하지 않는 키/값을 삭제 ======> 아무일이 일어나지 않음(에러아님)
dic.removeValue(forKey: "A") // 삭제후, 삭제된 값 리턴
dic.removeAll()
```

### 반복문과의 결합

```swift
let dict = ["A": "Apple", "B": "Banana", "C": "City"]

for (key, value) in dict {
    print("\(key): \(value)")
}
```

named tuple 형태로 전달이 되는데, 이를 활용가능 (enumerated 필요없어요)

실행마다 순서는 달라짐

# 집합(Set) (51강)

### 기본형태

```swift
// 정석
var set: Set<Int> = [1, 1, 2, 2, 3, 3, 3]
// 단축 문법
var set: Set = [1, 1, 2, 2, 3, 3, 3]

// 빈 세트 생성
let emptySet: Set<Int> = []
let emptySet1 = Set<Int>()
```

**배열이랑 똑같이 생겨서 타입을 지정해주지 않으면 배열로 인식한다이**

검색속도가 중요할 때 사용하거나

집합 개념 사용하고플 때

### 기본기능

```swift
set.count
set.isEmpty
set.contains(1)
set.randomElement() // 옵셔널 리턴
```

### 인덱스 접근 : 인덱스가 없으니 접근을 못한 → Subscript 문법도 없음

### 업데이트

```swift
set.update(with: 1)     // 이미 존재하면 옵셔널1 리턴
set.update(with: 7)     // 새로운 요소가 추가되면 ====> 리턴 nil
```

### 삭제

```swift
stringSet.remove("Swift")     // "Swift" 삭제한 요소를 리턴
stringSet.remove("Steve")       // 존재하지 않는 요소 삭제 -> nil    (에러는 발생하지 않음)
stringSet.removeAll()
```

### 집합

```swift
b.isSubset(of: a)   // true 부분집합 여부
a.isSuperset(of: b)    // true 상위집합 여부
d.isDisjoint(with: c) // 서로소 여부
var unionSet =  b.union(c) // 합집합
var interSet = a.intersection(b) // 교집합
var subSet = a.subtracting(b) // 차집합
var symmetricSet = a.symmetricDifference(b) // 대칭 차집합
```

### 반복문

```swift
let iteratingSet: Set = [1, 2, 3]

// 정렬되지 않은 컬렉션이기 때문에, 실행할때마다 순서가 달라짐
for num in iteratingSet {    
    print(num)
}
```

### 유의점

```swift
var newSet: Set = [1, 2, 3, 4, 5]

var newArray: Array = newSet.sorted()
```

정렬을 하면 배열로 리턴이 된다…

# 열거형의 기본 개념 (53강)

### 커스텀 타입 : 사용자 정의 타입

- Basic Type : Int, Double, String, Bool
- Custom Type : Enum, Class, Struct
- **Enum도 Type 입니다! → 맨 앞글자 대문자!**

## Enum(열거형) : 타입을 한정된 사례(case) 안에서 정의할 수 있는 타입

### 기본형태

```swift
enum BigTech {
    case microsoft
    case apple
    case google
    case amazon
}

var company1 : BigTech = BigTech.apple
var company2 : BigTech = .google
```

### 코드의 가독성과 안정성이 높아지기때문에 사용합니다

# 열거형의 원시값과 연관값 (54강)

## 원시값(Raw Values)을 가진 열거형

```swift
enum Direction : Int {
    case east
    case west
    case south
    case north
}
// 해당 rawValue 가 없을 수도 있기 때문에, 옵셔널 값으로 리턴
var east : Direction? = Direction(rawValue: 0)
var west : Direction = Direction(rawValue: 1)!
// 이렇게 rawValue 를 뽑을 수도 있음
var num : Int = Direction.east.rawValue
```

- 케이스에 숫자나 문자열을 매칭 시키는 것
    - Hashable 한 타입을 매칭 시킬 수 있고
    - 문자열을 매칭 시키면 케이스 이름이 문자열로 매칭된다
- west에 2를 매칭 시키면 east는 0, south는 3 이런식으로 눈치껏 잘 매칭
- 조금 더 편하게 사용하려고?

## 연관값(Associated Values)을 가진 열거형

```swift
enum Computer {
    case cpu(core: Int, ghz: Double)
    case ram(Int, String)
    case hardDisk(gb: Int)
}

var myChip1 = Computer.cpu(core: 8, ghz: 3.5)
var myChip2 = Computer.ram(16, "DRAM")
var myChip3 = Computer.hardDisk(gb: 256)
```

- **케이스 별로 상이한 특징이 있고, 이를 저장 활용하고픈 경우 → 구체적인 추가 정보**
- **선언시점이 아니라, 새로운 열거형 값을 생성할때 저장**

### 연관값의 활용

```swift
**// 이게 되네? : 와일드카드...?**
var chip = Computer.cpu(core: 8, ghz: 2.0)

switch chip {
case .cpu(core: 8, _):
    print("CPU 8코어 3.1GHz입니다.")
default:
    print("그 이외의 칩에는 관심이 없습니다.")
}

**// 바인딩으로 값 꺼내기 -> 이 방식을 Optional 바인딩이 내부에서 사용중**
switch chip {
case .cpu(let a, let b):    // let a = 연관값, let b = 연관값
    print("CPU \(a)코어 \(b)GHz입니다.")
case let .ram(a, _):
    print("램 \(a)기가램 입니다.")
case let .hardDisk(a) :
    print("하드디스크 \(a)기가 용량입니다.")
}
```

## 원시값과 연관값의 비교

- 값의 저장
    - 원시값 → **열거형의 선언시점**
    - 연관값 → **인스턴스 생성시점**
- 주의점
    - **열거형 연관값 동시 사용 불가**

# 옵셔널 타입에 대한 정확한 이해 (55강) - 옵셔널 파트 참고

### 옵셔널 타입의 내부 구현

```swift
enum Optional<Wrapped> {
       case some(Wrapped) **// 연관값을 가지고 있다**
       case none
   }
```

### 직접 만들어 보기

```swift
enum Optional {
    case some(Int)
    case none
}

// var num: Int? = 7 -> 얘랑 아래랑 거의 유사
var num : Optional = Optional.some(7)
var nil : Optional = Optional.none

**// 7을 어떻게 꺼내지? -> 코드내부에서는 아래의 방식과 비슷하게 옵셔널 바인딩이 진행됨
// .none 은 nil 과 완전히 동일하다**
switch num {
case .some(let a) :
    print(a)
case .none :
    print("nil")
}
```

### 정리

- Optional 은 **Enum 타입으로 구현**되어 있고, 케이스중 **.some 은 연관값을 가지고 있다**
- 값이 없으면 .none 케이스이고, 값이 있으면 .some(Int) 가 된다
- **Enum 연관값을 꺼내려면 패턴매칭 바인딩을 사용하는데 Swift 는 If let 바인딩으로 이를 사용할 수 있도록 구현해놓았다**
- .none 과 nil 은 연관값이 없으니 바인딩과는 무관하다
