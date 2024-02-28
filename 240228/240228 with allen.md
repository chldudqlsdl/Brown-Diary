# **4) 문자열화 - 숫자 등의 타입을 문자열로 변환 출력하기 (198강)**

### 출력 형식 지정자(Format Specifiers)

```swift
// String(format: String, arguments: CVarArg...)
String(format: "%.3f", pi)

var korean = "사용자의 이름은 %2$@ %1$@ 입니다."         // 1$ 첫번째 파라미터, 2$ 두번째 파라미터
string = String(format: korean, firstName, lastName)
```

- “%f” - 실수형
- “%.2f” - 소수점 두자리
- “%.3f” - 소수점 세자리
- “%d” - 정수형
- “%02d” - 정수형 두자리 0포함
- “%07.3f” - 소수점 세자리 0포함 7자리
- “%@” - 문자열 형식
- “%1$@” - 문자열 첫번째 파라미터

### NumberFormatter

```swift
let numberFormatter = NumberFormatter()
numberFormatter.roundingMode = .floor         // 버림으로 지정
numberFormatter.maximumSignificantDigits = 3  // 최대 표현하길 원하는 자릿수

let value = 3.1415926
var valueFormatted = numberFormatter.string(for: value)!    // 문자열화시키는 메서드
print(valueFormatted)   // 3.14
```

- .roundingMode              반올림모드
- .maximumSignificantDigits  최대자릿수
- .minimumSignificantDigits  최소자릿수
- .numberStyle               숫자스타일
    
    ```swift
    numberFormatter.numberStyle = .decimal
    let price = 10000000
    let result = numberFormatter.string(for: price)!
    print(result) // "10,000,000"
    ```
    
# 5) 스위프트 문자열의 이해 - 서브스트링 (199강)

### 개념

```swift
var greeting = "Hello, world!"

let index: String.Index = greeting.firstIndex(of: ",") ?? greeting.endIndex    // ,(콤마)의 인덱스
let beginning: String.SubSequence = greeting[..<index]// 처음부터 인덱스까지

print(beginning) // "Hello"
```

- beginning의 타입이 독특하다 → public typealias SubSequence = **Substring**
- `beginning` 은 `greeting` 문자열의 메모리 공간을 공유
- 수정이 일어나기 전까지는 메모리 공유
- 오랜기간 저장하기 위해서는, 새롭게 문자열로 저장할 필요

# 6) 문자열 다루기 / 문자열 인덱스 (200강)

## 문자열 → 배열

### 문자열 → 문자열 배열

```swift
var array: [String] = someString.map { String($0) }
```

### 문자열 → 문자 배열

```swift
var array2: [Character] = Array(someString)
```

## 배열 → 문자열

### 문자열 배열 → 문자열

```swift
var newString = array.joined()
```

### 문자 배열 → 문자열

```swift
var newString2 = String(array2)
```

### 문자열 뒤죽박죽 섞기

```swift
someString = "Swift"

someString.randomElement()     // 문자열에서 랜덤으로 뽑아내는 것 가능
someString.shuffled()          // 문자열의 경우 -> 섞어서 문자 배열 , 배열의 경우 -> 섞어서 배열

var newString3 = String(someString.shuffled())
var newString4 = someString.map { String($0) }.shuffled().joined()
```

# 문자열 다루기 / 서브스크립트 / 문자열 인덱스 (201강)

<aside>
💡 **문자열 인덱스는 정수가 아니다! ⇒ String.Index 타입이다**

</aside>

### 대소문자 변환 및 비교

```swift
string.lowercased()    // 전체 소문자로 바꾼 문자열 리턴 (원본 그대로)
string.uppercased()    // 전체 대문자로 바꾼 문자열 리턴 (원본 그대로)
string.capitalized     // 대문자로 시작하는 글자로 리턴하는 속성 (원본 그대로)
```

### 기본

```swift
emptyString.count 
emptyString.isEmpty 
```

### 문자열 접근

```swift
string[String.Index]
```

### 문자열 인덱스 타입

```swift
greeting.startIndex    
greeting.endIndex
greeting.index(greeting.startIndex, offsetBy: 2)
greeting.index(after: greeting.startIndex)    // 다음 인덱스
var firstIndex = greeting.firstIndex(of: " ")!    // 특정 문자의 첫번째 인덱스 리턴
```

### 인덱스 범위

```swift
var range = greeting.range(of: "Tag!")!
greeting[range]
```

### indices(index 복수형)

```swift
for index in greeting.indices {       // 개별 문자의 인덱스에 접근
    print("\(greeting[index]) ", terminator: "")
}
```

# 문자열 다루기 / 삽입 교체 추가 삭제 (202강)

### 삽입

```swift
// 문자 삽입
welcome.insert("!", at: welcome.endIndex)

// 문자열 삽입
welcome.insert(contentsOf: " there", at: welcome.index(before: welcome.endIndex))
```

### 교체

```swift
// 범위를 가지고 교체
if let range = welcome.range(of: " there!") {  
    welcome.replaceSubrange(range, with: " Swift!")    
    print(welcome)
}

// 해당 문자열이 존재하면 교체
var newWelcome = welcome.replacingOccurrences(of: "Swift", with: "World")
// "Swift"라는 문자열이 존재하면, "World"로 교체
```

### 추가

```swift
welcome.append("!")
```

### 삭제

```swift
// 인덱스를 가지고 지우기
welcome.remove(at: welcome.index(before: welcome.endIndex))  

// 범위를 가지고 지우기
var range = welcome.index(welcome.endIndex, offsetBy: -6)..<welcome.endIndex
welcome.removeSubrange(range)

// 앞 또는 뒤에서 갯수 만큼 삭제
welcome.removeFirst(갯수)

// 모두삭제
welcome.removeAll()
```

# 문자열 비교하기 / 비교 옵션 (203강)

<aside>
💡 insensitive : 민감하지 않은

</aside>

### caseInsensitiveCompare : 대소문자 무시하고 비교

```swift
var a = "Aaaaaaa"
var b = "abbbbbbb"

a.caseInsensitiveCompare(b) == ComparisonResult.orderedAscending // true
```

리턴타입은 ComparisonResult(열거형)

- .orderedSame // 동일
- .orderedAscending // 오름차순
- .orderedDescending // 내림차순

### .compare

```swift
var name = "Hello, Swift"

name.compare("hello", options: [.caseInsensitive]) == .orderedDescending 
```

options의 종류

- .caseInsensitive // 대소문자 무시하고 ⭐️
- .diacriticInsensitive // 발음구별기호 무시하고
- .widthInsensitive // 글자 넓이 무시하고
- .forcedOrdering // 강제적 오름차순/내림차순 정렬순 (대소문자 무조건 구별 의미)
- .literal // (유니코드 자체로) 글자그대로
- .numeric // 숫자 전체를 인식해서 비교
- .anchored // (앞부분부터) 고정시키고 (접두어)
- .backwards // 문자 뒷자리부터

options 는 OptionSet 프로토콜을 채택하고 있어서, 배열형식으로 전달가능한 것
