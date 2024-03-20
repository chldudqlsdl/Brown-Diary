# 앱의 생명 주기 (앱 47강)

<aside>
💡 **앱의 생명주기 : 앱의 비활성화 / (다른앱 또한 백그라운드로)전환 / 종료 시점을 파악하기 위함**
→ 관련 함수는 내부 매커니즘에 의해 자동으로 호출

</aside>

### 공부하는 이유?

- 전화오면 앱은 자동으로 통화화면으로 전환되는데, 실행중인 앱은 그리고 그 데이트는 어떻게 되나?
- 이런것을 앱의 생명 주기 관련 함수들이 자동으로 처리한다

### 개념(iOS 13 이후)

- **AppDelegate**
    - Not running (앱 실행전)
    - didFinishLaunchingOptions
- **SceneDelegate**
    - Foreground
        - sceneDidBecomeActive → sceneWillEnterForeground
        - Active(전화오면 Inactive)
        - sceneWillResignActive → sceneDidEnterBackground
    - Background
        - Background running
        (멜론 백그라운드 플레이)
        - sceneDidDIsconnect
- **AppDelegate**
    - Suspended
    - didDiscardSceneSession

- 씬(멀티태스킹의 창)의 개념이 도입되면서 탄생


### 과거(iOS 13 이전)

- 현재 SceneDelegate 의 역할까지도 모두 AppDelegate 가 담당

### 문법 구조

- UIApplicationDelegate ∙UIWindowSceneDelegate 의 프로토콜을 채택하고
- 메서드 구현을 하면 OS가 자동으로 이 메서드들을 실행시킨다

# UIView의 Drawing 사이클 - 1 (앱 48강)

<aside>
💡 **하나의 화면에서, 다시 그리는 시점을 파악하기 위함 (1/60초)**

</aside>

### 개념

- RunLoop 가 UI 를 변경한다
- 1초에 60번 화면을 다시 그린다(필요할 때만)
- layoutSubViews 는 자동호출되는데 직접호출 하려면 유도하는 함수로 호출
    - setNeedsLayout() - 동기 , **layoutIfNeeded() - 비동기가능**


- **updateConstraints - 오토레이아웃 조정해줘**
    - setNeedsUpdateConstraints() 
    - 다음 사이클에
    - updateConstraintsIfNeeded()
    - 당장
- **layoutSubviews 
- 하위 뷰 위치/ 크기 계산하고 배치해줘**
    - setNeedsLayout() - 다음 사이클에
    - layoutIfNeeded() - 당장
- **drawRect
- 실제 내부 컨텐츠 다시 그려줘(색상변경)**
    - setNeedsDisplay() - 다음 사이클에

# UIView의 Drawing 사이클 - 2 (앱 49강)

### updateConstraints()

```swift
override func updateConstraints() {
    print(#function)
    myButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5).isActive = true
    myButton.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.5).isActive = true
    myButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    myButton.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true

    super.updateConstraints()
}
```

- **super 메서드는 꼭 맨 아래에 써줄 것**
- constraint 를 조정해 뷰의 크기 변경 가능

### layoutSubviews()

```swift
override func layoutSubviews() {
    super.layoutSubviews()
    print(#function)

    myButton.frame.size = CGSize(width: self.frame.size.width/2, height: self.frame.size.height/2)
    myButton.center = CGPoint(x: self.bounds.midX, y: self.bounds.midY)
}
```

- **이 단계에서 frame 이 계산되기 때문에 직접 설정을 해줄 수 있는 것**

### viewDidLayoutSubview

- **layoutSubviews() 가 호출되고 난 뒤 뷰컨트롤러에서 호출할 수 있는 함수**
