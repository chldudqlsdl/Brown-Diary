# 두번째 앱 만들기 / 델리게이트 패턴 (앱14강)

### 델리게이트 패턴 개념

- 텍스트필드
    - 매우 세부 적인 동작의 형태가 있음 : ex) 입력 허락, 엔터키 감지, 입력 끝난 시점 감지…
- **텍스트필드는 뷰컨트롤러와 완벽히 분리된 객체이다**
- **텍스트필드의 동작을 뷰컨트롤러로 전달할 수 있도록 하는 것 ⇒ 델리게이트 패턴 (대리인)**

### 방법

- 뷰컨트롤러가 특정한 델리게이트 프로토콜을 채택
- 텍스트필드가 가진 델리게이트 속성에 뷰컨트롤러(델리게이트 프로토콜을 채택한)를 할당 → self
- 뷰컨트롤러에 프로토콜의 메서드 구현 (필수 or 선택) → 동작 감지 기능

### 비유

- 텍스트필드의 동작을 감지하기 위해서는 자격증이 있는 대리인이 필요하다
- 뷰컨트롤러는 대리인 자격증을 취득한다
- 텍스트필드는 대리인으로, 뷰컨트롤러를 배정한다
- 뷰컨트롤러는 필요한 동작 감지 기술(메서드)을 배워서 활용한다

# 델리게이트 패턴 - 직접구현 (앱15강)

```swift
protocol DeveloperDelegate {
    func coding()
    func coffeeChat()
}

**// 실제 이 부분의 구현 내용은 가려져있어 알 수가 없다**
class Company {
    let name : String = "Naver"
    
    var delegate : DeveloperDelegate?
    
    func coding() {
        delegate?.coding()
    }
    
    func coffeeChat() {
        delegate?.coffeeChat()
    }
}

class Human: DeveloperDelegate {
    let name : String = "charlie"
    
    func coding() {
        print("코딩중")
    }
    
    func coffeeChat() {
        print("잡담중")
    }
}

let charlie = Human()
let naver = Company()

naver.delegate = charlie

naver.coding()
naver.coffeeChat()
```

### 왜 프로토콜을 사용할 수 밖에 없는가?

```swift
var delegate : Human?
```

→ 이렇게 구현해도 가능하지만 미리 Human 이라는 타입으로 한정지어 버리는 결과가 발생

# 두번째 앱 만들기 / Responder (앱17강)

### Responder

- UIResponder 는 앱 이벤트 처리의 백본
- UIViewController UIView UIWindow 가 모두 여기에 속한다
- **이벤트가 발생하면 UIKit은 이를 리스폰더 객체에 전달한다**
- 리스폰더 객체가 이벤트를 처리하지 않으면, 리스폰더 체인의 다음 리스폰더를 찾으러 간다
- 유저가 UITextField 를 터치하면, 텍스트필드가 First Responder 가 된다 → 키보드 표시
- `becomeFirstResponder()`
    
    ```swift
    textField.becomeFirstResponder()
    ```
    
# 세번째 앱 만들기 / 코드로 UI짜기 - 1 (앱19강)

```swift
class ViewController: UIViewController {
    
    let emailTextFieldView = UIView()
    
    func makeUI() {        
        view.addSubview(emailTextFieldView)
        
        // 프레임 단위?
        emailTextFieldView.translatesAutoresizingMaskIntoConstraints = false
        
        emailTextFieldView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        emailTextFieldView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
        emailTextFieldView.topAnchor.constraint(equalTo: view.topAnchor, constant: 200).isActive = true
        emailTextFieldView.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
}
```

- UIView 선언
    - `let emailTextFieldView = UIView()`
- 기존 View에 얹기
    - `view.addSubview(emailTextFieldView)`
- 오토레이아웃 설정
    - `emailTextFieldView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true`
        - equalTo → 레이아웃의 기준이 되는 뷰
        - trailing → 음수
    - `emailTextFieldView.heightAnchor.constraint(equalToConstant: 40).isActive = true`
        - equalToConstant → 레이아웃의 기준이 필요없다
- **프레임 → 오토레이아웃**
    - `emailTextFieldView.translatesAutoresizingMaskIntoConstraints = false`

# 세번째 앱 만들기 / 코드로 UI짜기 - 2 (앱20강)

### 클로저 실행문 방식

```swift
let emailTextFieldView : UIView = {
    let view = UIView()
    view.backgroundColor = UIColor.darkGray
    view.layer.cornerRadius = 5
    view.layer.masksToBounds = true
    return view
}()
```

- 속성들이 정리가 된다
- **UIViewController 가 인스턴스를 만들면서 emailTextField 저장속성이 생기면서 클로저가 실행된다**
- **오토레이아웃까지 잡아줄 수는 없다(오토레이아웃이 늦게 생김) → 아마 라이프사이클 문제?**
- `view.addSubview(emailTextFieldView)` 는 클로저에 못 넣나요?
    - view 도 저장속성인데, emailTextFieldView 에서 이것을 사용하려면 → `lazy var` 써야!

