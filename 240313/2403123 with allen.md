# 화면 이동과 데이터 전달 - 코드를 통해 코드로 작성된 화면으로 이동 (앱30강)

### 이동 ∙ 풀스크린

```swift
@IBAction func codeNextButtonTapped(_ sender: UIButton) {
    let firstVC = FirstViewController()
    firstVC.modalPresentationStyle = .fullScreen
    present(firstVC, animated: true, completion: nil)
}
```

### 데이터전달

```swift
// viewController
@IBAction func codeNextButtonTapped(_ sender: UIButton) {
    let firstVC = FirstViewController()
    firstVC.someString = "굿모닝"
    present(firstVC, animated: true, completion: nil)
}

// NextViewController
class FirstViewController: UIViewController {
        var someString: String?
}
```

- 옵셔널 스트링으로 선언하면 생성자 만드는 수고 안 해도 된다
- 직접 레이블에 넣는 경우는 오류의 위험성이 있어서 변수로 전달한 후 이를 레이블로 전달

### dismiss

```swift
@objc func backButtonTapped() {
    dismiss(animated: true, completion: nil)
}
```

# 화면 이동과 데이터 전달 - 코드를 통해 스토리보드로 작성된 화면으로 이동 (앱31강) 👍

### 이동

- 먼저 스토리 보드와 뷰컨을 연결해준 후 진행 : 인스펙터에서 클래스 이름 ∙ id 설정

```swift
@IBAction func storyboardWithCodeButtonTapped(_ sender: UIButton) {
    if let secondVC = storyboard?.instantiateViewController(withIdentifier: "secondVC") as? SecondViewController {
        present(secondVC, animated: true, completion: nil)
    }
}
```

- **내가 사용할 뷰컨트롤러로 다운캐스팅!**
- 주의사항 : 실제로 뷰컨과 스토리보드는 따로 존재하기 때문에 아래 방식으로 하면 스토리보드와 연결 불가
    
    ```swift
    let firstVC = FirstViewController()
    present(firstVC, animated: true, completion: nil)
    ```
    

### 데이터 전달

```swift
if let secondVC = storyboard?.instantiateViewController(withIdentifier: "secondVC") as? SecondViewController {
    **// 이렇게 하면 안 됩니다!
    secondVC.mainLabel.text = "좋은점심"**
    secondVC.someString = "좋은점심"
****    present(secondVC, animated: true, completion: nil)
}
```

- **직접 전달 방식은 엄금 → 변수로 전달**
    - 현재는 뷰컨 인스턴스만 만들어진 상태
    - 스토리보드는 연결이 안 되어 있기에 mainLabel 이 nil 인 상태이다
    - **ViewDidLoad 사이클에서 비로소 스토리보드와 뷰컨트롤러가 연결이 되는 것**

### dismiss 는 동일

# 화면 이동과 데이터 전달 - 간접 세그웨이 (앱32강)

### 세그웨이 연결

- 스토리보드에서 컨트롤 누르고 **뷰컨**을 드래그
- 세그웨이에 id 설정해주기

### 세그웨이 이동

```swift
@IBAction func storyboardWithSegueButtonTapped(_ sender: UIButton) {
    performSegue(withIdentifier: "toThirdVC", sender: self)
}
```

- withIdentifier : 어떤 세그웨이를 탈지
- sender : 발송인 뷰컨

### 세그웨이 데이터 전달

```swift
override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "toThirdVC" {
        if let thirdVC = segue.destination as? ThirdViewController {
            thirdVC.someString = "좋은저녁"
        }
    }  
}
```

- `performSegue()` 하면 `prepare()` 가 실행된다
- `segue` 에는 속성으로 identifier ∙destination 등이 들어있다
- 다운캐스팅

### dismiss 는 동일

# 화면 이동과 데이터 전달 - 직접 세그웨이 (앱33강)

### 세그웨이 연결

- 스토리보드에서 컨트롤 누르고 **버튼**을 드래그
- 세그웨이 id 설정

### 세그웨이 이동

- **버튼을 누르면 자동으로 `performSegue()` 가 실행되기에 따로 구현해줄 필요가 없다**

### 세그웨이 데이터 전달

```swift
override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toFourthVC" {
        if let fourthVC = segue.destination as? FourthViewController {
            fourthVC.someString = "좋은밤"
        }
    }     
}
```

- 똑같이 `prepare()` 활용해주면 되고

### 조건에 따른 이동

```swift
override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
    if identifier == "toFourthVC" {
        return false
    }
}
```

- 직접 세그웨이에서는 `performSegue()` 실행하기 전에 `shouldPerformSegue()` 를 들른다
- 여기서 조건에 따라 Bool 리턴하여 이동 할지 말지를 결정할 수 있다
    - 간접은 세그웨이는 `performSegue()` 실행 권한이 우리에게 있으니 `shouldPerformSegue()` 가 있을 필요가 없지요
