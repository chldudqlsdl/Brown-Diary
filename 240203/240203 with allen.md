# iOS Architecture / Framework (70강)

### Swift ∙ Framework ∙ Library

**Swift 문법 → 레고를 조립하는 방법 (홈에 맞춰서 끼워라)**

**프레임워크 → 레고 세트(마트에 파는 것) ⇒ 원하는 프로그램을 만들 수 있는 부품**

**라이브러리 → 레고 조립할 때 편하게 하라고 만들어 놓은 덩어리(버튼 10개짜리 버튼) ⇒ 미리 만들어 놓은 필요 부분**

### Foundation ∙ UIKit

얘네는 둘다 프레임워크이다

프레임워크는 크게 **4Layer**

- Cocoa Touch Framework → 개발 기초, 필수 기능
- Media Framework → 미디어
- Core Services Framewokr → 시스템 서비스
    - Foundation 은 요기 들어있음
- Core OS Framework → 보안, 하드웨어(OS니까)

UIkit에도 Foundation이 들어있어서 사용가능

# (앱 - 3: 가위바위보) 앱 만들기 / 코드 설정하기 - 2 (75강)

enum 을 새로운 파일로 만든다 

**앱을 실행하면, 모든 파일들이 코데힙스 중 코드영역에 올라간다**

**enum의 경우 데이터에도 올라간다 → 전역**

원시값 설정하면 여러모로 편하다 → Int.random(0…2) 사용가능!

```swift
enum Rps: Int {
    case rock
    case paper
    case scissors
}
```

UIButton IBAction 의 `sender.currentTitle` 하면 클릭된 버튼의 타이틀 얻을 수 있음
(버튼 스타일이 Plain 이면 currentTitle 을 얻을 수 없대요 → default )

- 이거를 Switch문과 결합해도 좋겠다
