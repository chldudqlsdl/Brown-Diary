# 옵셔널 타입의 기본 개념 (43강)

### 탄생 설화

```swift
var name : String

print(name)
```

- String 타입(반드시 String 타입임)의 name의 메모리 공간이 생긴다
- print 가 name에 접근하니 값이 없대
- **String 이라고 그래놓고 왜 값이 없어! → 앱이 꺼짐**
    - name 에 값이 있다가 없을 수도 있는데, 크래쉬가 나니 이를 해결하기 위해 옵셔널이 탄생

### 개념 이해

```swift
// 기본 형태
let num1: Int? = 2             // 간편표기
let num2: Optional<Int> = 0    // 정식문법
```

- Int? → **메모리 공간에 입시 타입(Enum?)으로 저장한다는 개념** ⇒ 포장지
    - 임시타입 안에는 **Int 와 ‘값없음’** 이 들어갈 수 있는데
    - ‘값없음’ 은 에러를 발생시키니까
    - 얘들을 임시타입이라는 포장지에 싸서 넣어놓는데 아래의 형태로 들어있는것
        - Int → **Optional(Int)**
        - 값없음 → **nil**
    - **임시값 자체로 사용할 수는 없고 포장지를 벗겨서 사용해야한다**
- 도식화
    - 메모리공간
        - Optional(Int) = Int + 포장지
        - nil = 값없음 + 포장지

### 보충

- 자동 초기화 → 옵셔널 타입에 아무것도 할당하지 않으면 nil 로 자동 초기화 됩니다
    
    ```swift
    var optionalName: String?
    print(optionalName)
    ```
    
- 타입 추론 → Int? String? 인지 타입 추론이 안되니까 에러
    
    ```swift
    var optionalNum = nil
    ```
    
- 값 복사
    - b 도 Int? 타입이 된다 - 타입이 복사됨
    - Int 타입을 집어 넣으면  그대로 Int?
    
    ```swift
    var a: Int? = 7 
    var b = a   
    
    var c: Int = 5
    b = c     
    ```
    
- 연산 불가능 : Value of optional type 'Int?' must be unwrapped to a value of type 'Int’
    - 포장지에 둘러쌓여 있어서 Int 가 아니고 그래서 연산 불가해요

# 옵셔널값의 추출 방법 (44강)

다섯가지 방법이 있는데, 옵셔널 체이닝 빼고 4가지를 중요도에 따라서 정리함

## 옵셔널 바인딩

### if let 바인딩

```swift
// 기본형태
var myName : Int?

if let name = myName {
    code
}
```

- **옵셔널 바인딩에서만 사용되는 독특하고 예외적인 문법**
    - if 뒤에는 참 ∙ 거짓을 판별할 수 있는 표현식이 와야하는데 이상하게 생겼자나
- name이 상수인데 myName 을 name에다 바인딩 한다
    - **name의 타입은 myName에서 옵셔널이 벗겨진 타입** (? 가  없는)
    - **myName 이 nil이면 상수(name) 에 안 담김**
    - **myName dl nil이 아니면 상수에 담김**
- **바인딩(담기면) 중괄호의 코드를 실행함**

### guard let 바인딩

```swift
// 기본형태
var myNum : Int?

func nilCheck(myNum : Int?) {
    guard let num = myNum else {
        print("nil")
        return
    }
    print(num)
}

nilCheck(myNum: nil)
```

- **guard 문에서 선언된 변수를 아랫문장에서 사용 가능하다!**
    - print(num) 부분
    - if 문은 그게 안됨…
- guard 는 역시 함수나 반복문이랑 같이 사용되는구나…

## Nil-Coalescing

coalesce : 병합하다

```swift
var id : String?

var InputID = id ?? "아이디를 입력해주세요"
```

- id 값이 nil 이면 ?? 뒤의 값을 사용합니다
- Coalescing 과정에서 unwrapping 되어서 **InputID의 타입은 String**

## 기타

### 강제추출(Forced Unwrapping)

```swift
var num : Int? = 10
num!
```

- num 값이 nil인 경우에는 에러

### nil 아닌지 확인후, 강제추출

```swift
var myWord : String?
if myWord != nil {
    print(myWord)
}
```

- 그냥 논리적인 방법

### 옵셔널 체이닝 → 다음 강의에서

# 스위프트 컬렉션의 기본 개념 / 배열 (46강)

## 컬렉션

- **데이터를 효율적으로 관리하기 위한 자료형 → 바구니**
- 배열 : 데이터 순서대로 저장
- 딕셔너리 : 키와 값 하나의 쌍으로 만들고, 순서가 없다
- 세트 : 순서가 없는 집합

## 배열

### 기본형태

```swift
var numsArray : Array<Int> = [1, 2, 3, 4, 5]
```

### 타입 표기

```swift
var numsArray1 : Array<Int> = [1, 2, 3, 4, 5]
var numsArray2 : [Int] = [1, 2, 3, 4, 5]
```

### 빈배열 생성

```swift
let emptyArray1: [Int] = []
let emptyArray2 = Array<Int>()
let emptyArray3 = [Int]()
```

### 기본

```swift
numsArray.count
numsArray.isEmpty
numsArray.contains(1)  //파라미터로 값을 전달
numsArray.randomElement()
numsArray.swapAt(0, 1)
```

### 요소접근

```swift
stringArray[0] // 서브스크립트 문법

**stringArray.first // 첫번째 값 옵셔널 요소로 리턴 -> 있을지 없을지 모르니까?**
stringArray.startIndex // 얘는 왜 옵셔널 아니지?
stringArray.firstIndex(of: "Apple") // 얘는 또 옵셔널 리턴
stringArray[0...1] // 범위 연산자 가능

// 값이 다섯개 들어있는 배열의 endIndex 는 4가 아니라 5이다
// 그래서 마지막 값의 인덱스를 뽑으려면 -1 해야 함
stringArray.endIndex 
```

### 삽입

```swift
var alphabet = ["A", "B", "C", "D", "E", "F", "G"]

alphabet.insert("c", at: 4)

alphabet.insert(contentsOf: ["a","b","c"], at: 0) // 배열을 삽입
```

### 교체

```swift
alphabet[0] = "a" // 요소 교체하기

alphabet[0...2] = ["x", "y", "z"] // 범위를 교체하기

alphabet[0...1] = [] // 원하는 범위 삭제
```

### 추가

```swift
alphabet += ["H"] // 이게 되네

alphabet.append("H")   // 맨 마지막에 추가하는 것

alphabet.append(contentsOf: ["H", "I"])
```

### 삭제

```swift
alphabet[0...2] = []   //빈배열 전달하면 해당 범위가 삭제
alphabet.remove(at: 2)  // 삭제하고, 삭제된 요소 리턴
alphabet.removeSubrange(0...2) // 요소 범위 삭제

alphabet.removeFirst()   // 맨 앞에 요소 삭제하고 삭제된 요소 리턴 (리턴형 String)
alphabet.removeFirst(2)   // 앞의 두개의 요소 삭제 ===> 리턴은 안함

alphabet.removeAll()
// 비어 있는데 삭제하면 에러납니다
```

### 정렬

```swift
nums.sort()   // 배열을 직접 정렬 (오름차순) (배열리턴 하지 않음)
nums.sorted()    //오름차순으로 정렬 -> 배열 리턴

nums.reverse()   // 요소를 역순으로 정렬  (배열리턴 하지 않음)
nums.reversed()  // 리턴

nums.shuffle()    // 요소의 순서 랜덤으로 직접 바꾸기
nums.shuffled()
```

### 활용

```swift
// 언래핑
if let lastIndexOfP = puppy1.lastIndex(of: "p") {
    puppy1.remove(at: lastIndexOfP)
}
```

### enumerated

```swift
var nums = [10, 11, 12, 13, 14]

for tuple in nums.enumerated() {
    print(tuple)
}
**// (offset: 0, element: 10) -> named tuple 형태로 프린트
// index 와 값을 한 번에 사용할 수 있다**

// print("\(tuple.0) - \(tuple.1)") -> 이렇게 접근도 가능하고
```

### 기타

반복문 결합

배열안의 배열

배열의 비교
