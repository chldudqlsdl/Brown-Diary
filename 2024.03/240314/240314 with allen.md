# 디자인패턴 이론 (앱40강)

<aside>
💡 **화면별로 파일을 나누잖아? 화면 내에서도 기능에 따라 파일을 나눠보자!**

</aside>

### 디자인패턴

- 검증된 ∙ 정형화된 개발 패턴
- 효율적 유지보수 ∙ 지속적인 기능 개발을 위한 템플릿

### MVC

- **Model - 비즈니스 로직**
- **View - UI**
- **Controller - 모델의 정보를 뷰에 어떻게 표시할지 (중재자)**

# BMI앱(4번째앱) / MVC패턴 적용하기 (앱 41강)

### MVC 패턴 적용

- 뷰컨트롤러의 핵심 논리들 (BMI 계산 ∙ 색 리턴) Model 로 옮긴다
    - Model - BMIManager → 클래스 or 구조체
- 뷰컨트롤러에서 BMIManger 저장속성으로 인스턴스 선언
    - 앞으로는 이 manager 를 통해서 컨트롤러와 모델이 커뮤니케이션을 할 예정

### 팁

- 옵셔널로 리턴을 하지말고 ?? 를 활용해 기본값 리턴
- 프로젝트가 커지면 모델이 힙에 저장되는 것이 좋다 → 클래스로 선언
    - 이유는 잘 모르겠…
    
# **BMI앱(4번째앱) / MVC패턴 적용하기 2 (추가 리팩토링) (앱 42강)**

### 추가 리팩토링

- 현재는 bmi 값 ∙ 배경색 ∙ 어드바이스를 따로 따로 받아오는데 이것을 묶고싶다
- BMI 라는 이름의 Model 를 생성하여 세 속성을 가지는 구조체를 만들어준다

# 로그인앱(3번째앱) / MVC패턴 적용하기 (앱 44강)

### 코드베이스로 화면 구현을 한 경우 MVC 패턴을 어떻게 적용하는가?

### View 분리

- View 파일 만들어서 UIView 클래스를 생성한다
- 이 클래스 안에 View 관련한 코드를 전부 옮긴다
- 원래는 ViewDidLoad 에 있던 코드들은 UIView의 생성자에 넣는다
    - 참고하세요 : [UIView.init()](https://www.notion.so/UIView-init-17ad1dd6bdb64bdfa69ea979f8f74961?pvs=21)
    
    ```swift
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
        addViews()
        setConstraints()
    }
    ```
    

### View 불러오기

```swift
final class ViewController: UIViewController {
    
    private let loginView = LoginView()
    
    override func loadView() {
        // super.loadView() 필요없음
        view = loginView
    }
}
```

- UIViewController 에 `func loadView()` 가 있다
    - 뒤에서 배우겠지만 라이프사이클상 ViewDidLoad() 보다 앞에 이루어짐

### 여기서 주의점

```swift
override func viewDidLoad() {
    super.viewDidLoad()
    print()
    setupAddTarget()
}

func setupAddTarget() {
    loginView.loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
    loginView.passwordResetButton.addTarget(self, action: #selector(resetButtonTapped), for: .touchUpInside)
}

@objc func loginButtonTapped() {
    print("다음 화면으로 넘어가기")
}

@objc func resetButtonTapped() {
    self.present(alert, animated: true, completion: nil)
}
```

- 다음 화면으로 넘어가는 코드는 View 보다는 Controller 와 관련이 깊어서 View 파일로 옮기지 않는다

# 뷰컨트롤러의 생명주기 - 1 (앱 45강)

<aside>
💡 **OS에 의해서 뷰컨트롤러 생명주기 관련 함수들은 자동으로 호출
viewDidLoad 는 뷰가 생성될 때 한번만 호출 (스토리보드의 뷰와 연결이 끝난 시점에 호출)**

</aside>

### 뷰컨트롤러 생명주기 개념

- 순서
    
    
- 호출방법
    
    ```swift
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("VC-1 viewWillAppear 호출됨")
    }
    ```
    
    - animated 를 넣어준다
- 콘솔창 (FullScreenCover 가 사용된 두개의 화면 + 버튼 세그웨이로 이동)
    
    
    - DidAppear 가 되어야 DidDisappear 가 된다
    - viewDidLoad 는 메모리에 올라가는 시점에 한번만 호출

# 뷰컨트롤러의 생명주기 - 2 (앱 46강)

### loadView()

- 코드로 뷰를 작성할 때 사용한다
- `super.loadView()` 호출할 필요 없음 - 공식문서
- 스토리보드로 구현한 화면에서 사용하면 오류

### viewWillAppear 와 viewDidAppear 사이에는 뭐가 많다!

- Constraint 가 Layout 보다 먼저인가…?

### 왜 생명주기 알아야 하나?

- 화면 이동할 때 데이터를 잘 바꿔줘야지!
