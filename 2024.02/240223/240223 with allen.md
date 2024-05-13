# 날짜와 시간 다루기 / Date구조체의 이해 (188강)

### Date 구조체

```swift
let now = Date()
print(now) 

/// 2024-02-23 06:45:49 +0000

let interval = now.timeIntervalSinceReferenceDate  // 실제 몇 초 지났는지
```

- 2001.1.1 00:00:00 부터 몇 초가 떨어져 있는지를 알아내서
- UTC 기준 날짜와 시간을 저장한다(암시적)

```swift
let yesterday = now - 86400
```

- 이게 가능…?
    
    [Date | Apple Developer Documentation](https://developer.apple.com/documentation/foundation/date)
    
    ```swift
    // 공식문서 : Date + Timeinterval(typealias Double)가능
    
    let oneday = 86400 
    
    let tomorrow1 = now + oneday // 불가 : 이미 oneday는 Int로 타입이 정해짐
    
    let tomorrow2 = now + 86400 // 가능 : 자동으로 86400은 Double 타입으로 바뀌어서 덧셈
    ```
    

### 제대로 다루려면

- **Calender : 달력 → 년월일시분초요일**
- **DateFormatter: (형식)문자열로 변경해주는 클래스**

# Calendar구조체의 이해 (189강)

<aside>
💡 **절대 시점(Date)을 연대/연도/날짜/요일과 같은 달력의 요소로 변환을 돕는 객체**

</aside>

### 인스턴스 생성

```swift
var calendar = Calendar.current **// Calendar의 타입속성임!**
let calendar1 = Calendar(identifier: .gregorian)
```

- 캘린더 정보 몇가지
    - Identifier : 달력의 종류(불기, 이슬람, 그레고리안)
    - locale : 지역 설정 → 표기방식
    - timeZone : 시간대

### 요소(연월일요일) 확인 : .component

```swift
// Calendar.Component -> 중첩타입? => enum일 가능성이 높다!
calendar.component(component: Calendar.Component, from: Date)

// 1) 날짜 - 년 / 월 / 일
let year: Int = calendar.component(.year, from: now)
let month: Int = calendar.component(.month, from: now)
let day: Int = calendar.component(.day, from: now)

// 2) 시간 - 시 / 분 / 초
let timeHour: Int = calendar.component(.hour, from: now)
let timeMinute: Int = calendar.component(.minute, from: now)
let timeSecond: Int = calendar.component(.second, from: now)

// 3) 요일
let weekday: Int = calendar.component(.weekday, from: now)
```

### 여러개의 요소 확인 : .dateComponents

```swift
var myDateCom = myCal.dateComponents([.year, .month, .day], from: now)

myDateCom.year
myDateCom.month
myDateCom.day
```

## 몇가지 실사용례

### 요일계산

```swift
// (원시값)열거형으로 선언된 요일
enum Weekday: Int {
    case sunday = 1, monday, tuesday, wednesday, thursday, friday, saturday
    
    // ⭐️ 타입 계산속성
    static var today: Weekday {
        let weekday: Int = Calendar.current.component(.weekday, from: Date())  // 요일을 나타내는 정수
        return Weekday(rawValue: weekday)!
    }
}

// 오늘이 무슨요일인지
let today = Weekday.today
```

### 두 날짜 사이의 일수 계산

```swift
let startDate = Date()
let endDate = startDate.addingTimeInterval(3600 * 24 * 60)

let calendar2 = Calendar.current
let someDays = calendar2.dateComponents([.day], from: startDate, to: endDate).day!

print("\(someDays)일 후")
```

# DateFormatter의 이해 (190강)

<aside>
💡 **Date 를 원하는 형식의 문자열로 변환하는 방법을 제공하는 클래스**

</aside>

### 인스턴스 생성의 4단계

```swift
let formatter = DateFormatter()

// (1) 지역 설정
formatter.locale = Locale(identifier: "en_US")

// (2) 시간대 설정(기본설정이 있긴 하지만)
formatter.timeZone = TimeZone.current

// (3) 날짜 형식 선택
formatter.dateStyle = .full           // "Tuesday, April 13, 2021"
formatter.dateStyle = .long         // "April 13, 2021"
formatter.dateStyle = .medium       // "Apr 13, 2021"
formatter.dateStyle = .none         // (날짜 없어짐)
formatter.dateStyle = .short        // "4/13/21"

// (4) 시간 형식 선택
formatter.timeStyle = .full           // "2:53:12 PM Korean Standard Time"
formatter.timeStyle = .long         // "2:54:52 PM GMT+9"
formatter.timeStyle = .medium       // "2:55:12 PM"
formatter.timeStyle = .none         // (시간 없어짐)
formatter.timeStyle = .short        // "2:55 PM"

// 실제 변환하기 (날짜 + 시간) ===> 원하는 형식
let someString1 = formatter.string(from: Date())
```

### 커스텀 생성

```swift
formatter.dateFormat = "yyyy/MM/dd"
let someString2 = formatter.string(from: Date())
```

### 문자열에서 Date로 변환

```swift
let someDate = newFormatter.date(from: "2021/07/12")!
```

# 접근제어의 기본 개념에 대한 이해 (192강)

### 접근제어는 왜 필요한가?

1. 코드의 세부구현 내용을 숨길 수 있음
2. 코드 영역이 분리되어 효율적 관리가 가능하다
3. 컴파일 시간이 줄어든다

### 스위프트의 5가지 접근수준

모듈 : 프레임워크, 라이브러리, 앱 등 import 해서 사용할 수 있는 외부의 코드

- **open : 다른 모듈에서 접근가능(상속 / 재정의 가능) → 클래스만 해당**
- **public : 다른 모듈에서 접근가능(상속 / 재정의 불가) → 구조체 / 열거형의 마지노선**
- **internal : 같은 모듈에서만 접근 가능 → 디폴트 설정**
- **fileprivate : 같은 파일 내에서만 접근 가능**
- **private : 같은 scope(중괄호) 내에서만 접근 가능**

### 접근제어를 가질 수 있는 요소

스위프트 문서 왈 Entity

쉽게 생각하면 → 타입 ∙ 변수 ∙ 함수 ∙프로토콜

### 기본원칙

타입은 타입을 사용하는 변수(속성)나, 함수(메서드)보다 높은 수준으로 선언되어야함

```swift
var some: String = "접근가능" 
```

**→ 내부에서 더 낮은 타입을 사용하면, 접근을 못하니까**

### 관습적인 패턴

```swift
class SomeOtherClass {
    private var _name = "이름"         // 쓰기 - private
    
    var name: String {                // 읽기 - internal
        return _name
    }
}
```

- 속성(변수)를 선언시 private으로 외부에 감추려는 속성은 _(언더바)를 사용해서 이름 지음

```swift
class SomeAnotherClass {
    private(set) var name = "이름"      // 읽기 - internal / 쓰기 - private
}
```

- 이렇게 쓰기에 대해서만 접근제어를 할 수도 있음
