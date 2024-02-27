# 1) 아스키코드와 유니코드 (195강)

### 아스키코드와 유니코드

- 문자는 어떤 체계에 의해서 숫자로 메모리에 저장된다
- 영어는 아스키코드로 표현이 가능하고
- 스위프트는 UTF(유니코드) 를 사용한다

### 유니코드 인코딩 방법

- UTF-8 : 1 ~ 4 bytes 가변길이 인코딩(가변으로 하면 메모리 절약)
    - 웹과 대부분 체계에서 사용
    - 가(한글) → 234, 176, 128
- UTF-16 : 2 ~ 4 bytes 가변길이 인코딩
- UTF-32 : 4 bytes 인코딩(21비트만 사용)
    - 문자에 따라 모든 값이 색인화 되어 있어 인코딩 변환 처리가 필요없음
    - 많은 저장 공간을 사용한다는 단점

### Swift?

- UTF-32 를 채택
- UTF-8 ∙ 16 으로도 쉽게 변환 가능
- UTF-32값 → 문자열
    
    ```swift
    someString = "\u{53}\u{6F}\u{6D}\u{65}\u{20}\u{53}\u{77}\u{69}\u{66}\u{74}\u{1F603}"
    ```
    
- UTF-32값 → UTF-8 ∙ 16
    
    ```swift
    for codeUnit in dogString.utf8 {             //  8비트의 숫자값
        print("\(codeUnit) ", terminator: "")
    }
    
    for scalar in dogString.unicodeScalars {      // 32비트의 숫자값
        print("\(scalar.value) ", terminator: "")
    }
    ```
    

### 주의점

- 문자열을 글자의 의미단위로 사용
    
    ```swift
    var hangul1 = "\u{D55C}"     // "한"
    print("\"한\"의 글자수: ", hangul1.count)
    
    var hangul2 = "\u{1112}\u{1161}\u{11AB}"      // "ㅎ" "ㅏ" "ㄴ"
    print("\"ㅎ\"+\"ㅏ\"+\"ㄴ\"의 글자수: ", hangul2.count)
    
    // .count 가 둘다 1이다
    ```
    
- 서브스크립트 문법으로 단순 인덱스 접근도 그래서 불가

### NSString

- String - NSString 브릿징이 가능 → 타입캐스팅으로 호환
- 특수한 경우 사용할 일이 있음 (NSAttributedString -  글자별로 색 다르게 하기)
- 유니코드 처리 방식은 다르다

# 2) 문자열의 기본 (196강)

### Multiline String Literals

```swift
let quotation = """
The White Rabbit put on his spectacles.  "Where shall I begin,
please your Majesty?" he asked."
"""
print(quotation)
```

- “”” 줄에는 문자열 입력 불가
- 줄바꿈 하지 않으려면 \(백슬레시) 입력
- 마지막(""")는 들여쓰기의 기준의 역할

### Escape sequences

- \t (탭)
- \n (줄바꿈 - 개행문자)
- \r (캐리지 리턴 - 앞줄이동)
- \" (쌍따옴표)
- \' (작은따옴표)
- \u{유니코드값} (1~8자리의 16진수)

### Extended String Delimiters - #

- Raw String 방식을 사용 가능

# 3) 문자열 보간법 (197강)

### 동작원리

```swift
struct Dog {
    var name: String
    var weight: Double
}

let dog = Dog(name: "초코", weight: 15.0)
print("\(dog)")      // Dog(name: "초코", weight: 15.0)  출력 형태를 애플이 지정해 놓음
print(dog)
```

→ 애플이 지정해놓은대로 출력 ⇒ 이것을 커스텀할 수 있다

### 커스텀

<aside>
💡 \( ) → appendInterpolation()을 실행

</aside>

```swift
struct Point {
    let x: Int
    let y: Int
}

let p = Point(x: 5, y: 7)

extension String.StringInterpolation {
    mutating func appendInterpolation(_ value: Point) {
        appendInterpolation("X좌표는 \(value.x), Y좌표는 \(value.y)입니다.")
    }
}
```

d
