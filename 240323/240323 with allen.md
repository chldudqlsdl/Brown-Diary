# **여섯번째 앱 만들기 / 스토리보드로 네비게이션바/탭바 만들기 (앱 52강)**

### 스토리보드로 네비게이션 바 ∙ 탭 바 만들기

- 스토리 보드에 내비게이션 바 얹기
    - 얹고 싶은 뷰컨 클릭 후 → Embed in ⇒ **Naviagation Controller**
- 이동하고 싶은 뷰컨 사이에 세그웨이 연결
    - Action Segue → Show
- Navigation Controller 상단의 바 → Navigation Bar
    - 뷰컨 상단의 바 → Navigation Item
- Navigation Bar 색 바꾸기
    - 내브바는 내브컨에 있다
    - Appearances → Scroll Edge
- **탭 바 생성하기 ⇒ 탭바가 내브바 보다 더 하위에 있다(큰형님)**
    - Navigation Controller 클릭
    - Embed in → **Tab Bar Controller**
- 탭 바와 새로운 뷰컨트롤러 연결하기
    - 탭 바 컨트롤 누르고, 새로운 뷰 컨트롤러로 드래그
    - 설정은 알아서 변경하시고

# **여섯번째 앱 만들기 / 코드로 네비게이션바/탭바 만들기 응용 및 정리 (앱 54강)**

<aside>
💡 **지금까지는 로그인화면에서 버튼을 누르면 밑에서 탭바컨트롤러가 올라와 덮어줬는데 이런 식이면 힙에 로그인 화면에 남아있게 된다 → 탭바 컨트롤러는 밑에 있고 그 위에 로그인 화면이 덮어져있는 방식으로 전환하자**

</aside>

### 조건부로 LoginVC 띄우기

```swift
class FirstViewController: UIViewController {
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // ⭐️ 로그인이 되어있지 않다면 로그인화면 띄우기
        if !isLoggedIn {
            let vc = LoginViewController()
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: false, completion: nil)
        }
    }
}
```

### 그렇다면 맨 아래에 탭바 컨트롤러를 어떻게 깔지? ⇒ SceneDelegate

```swift
class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    // 첫화면이 뜨기전에, 탭바를 내장시키기⭐️⭐️⭐️
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)

        // 탭바컨트롤러의 생성
        let tabBarVC = UITabBarController()
        
        // 첫번째 화면은 네비게이션컨트롤러로 만들기 (기본루트뷰 설정)
        let vc1 = UINavigationController(rootViewController: FirstViewController())
        let vc2 = SecondViewController()
        let vc3 = ThirdViewController()
        let vc4 = FourthViewController()
        let vc5 = FifthViewController()
        
        // 탭바 이름들 설정
        vc1.title = "Main"
        vc2.title = "Search"
        vc3.title = "Post"
        vc4.title = "Likes"
        vc5.title = "Me"
        
        // 탭바로 사용하기 위한 뷰 컨트롤러들 설정
        tabBarVC.setViewControllers([vc1, vc2, vc3, vc4, vc5], animated: false)
        tabBarVC.modalPresentationStyle = .fullScreen
        tabBarVC.tabBar.backgroundColor = .white
        
        // 탭바 이미지 설정 (이미지는 애플이 제공하는 것으로 사용)
        guard let items = tabBarVC.tabBar.items else { return }
        items[0].image = UIImage(systemName: "trash")
        items[1].image = UIImage(systemName: "folder")
        items[2].image = UIImage(systemName: "paperplane")
        items[3].image = UIImage(systemName: "doc")
        items[4].image = UIImage(systemName: "note")
            
        // 기본루트뷰를 탭바컨트롤러로 설정⭐️⭐️⭐️
        window?.rootViewController = tabBarVC
        window?.makeKeyAndVisible()
    }
}
```

### FirstViewController 에 로그인 여부 변경해주기

```swift
@objc func loginButtonTapped() {
    
    // 전화면의 isLoggedIn속성에 접근하기 ⭐️
    if let presentingVC = presentingViewController { // 옵셔널 바인딩
        let tabBarCon = presentingVC as! UITabBarController   // 탭바에 접근하기
        let nav = tabBarCon.viewControllers?[0] as! UINavigationController  // 네비게이션바에 접근하기
        let firstVC = nav.viewControllers[0] as! FirstViewController  // FirstVC에 접근하기
        firstVC.isLoggedIn.toggle()  // 로그인 되었다고 상태 변화시키기 (실제 앱에서 이렇게 구현할 일은 없음)
    }
    
    dismiss(animated: true, completion: nil)
}
```

### 네비게이션 바 설정 변경

```swift
let appearance = UINavigationBarAppearance()
appearance.configureWithOpaqueBackground()  // 불투명으로
//appearance.backgroundColor = .brown     // 색상설정

//appearance.configureWithTransparentBackground()  // 투명으로

navigationController?.navigationBar.tintColor = .blue
navigationController?.navigationBar.standardAppearance = appearance
navigationController?.navigationBar.compactAppearance = appearance
navigationController?.navigationBar.scrollEdgeAppearance = appearance

title = "Main"
```

### 내비게이션바 컨트롤러에서 화면이동

- present ⇒ push
- dismiss ⇒ pop
