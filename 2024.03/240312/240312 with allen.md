# 세번째 앱 만들기 / 코드로 UI짜기 - 클로저 실행문 (앱20강)

### 모서리 둥글게

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

# 세번째 앱 만들기 / 코드로 UI짜기 - 오토레이아웃 (앱21강)

- `.addSubview` 사용할거면 `lazy var`
    - `.addSubview` 순서도 잘 지켜줘야 한다
    - 가장 바깥의 `view` 에 올리는 것도 잊지 말기
- `.translatesAutoresizingMaskIntoConstraints` → 애 있어야 오토레이아웃 사용가능
- `.trailingAnchor` → 마이너스 사용하는 상황 있다
- `NSLayoutConstraint.activate` → 얘 사용하면 `.isActive = true` 사용 안해도 된다

```swift
class ViewController: UIViewController {
    
    lazy var emailTextFieldView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        view.layer.cornerRadius = 5
        view.clipsToBounds = true
        view.addSubview(emailTextField)
        view.addSubview(emailInfoLabel)
        return view
    }()
    
    let emailInfoLabel : UILabel = {
        let label = UILabel()
        label.text = "이메일주소 또는 전화번호"
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .white
        return label
    }()
    
    let emailTextField : UITextField = {
        var tf = UITextField()
        tf.frame.size.height = 48
        tf.backgroundColor = .clear
        tf.textColor = .white
        tf.autocapitalizationType = .none
        tf.autocorrectionType = .no
        tf.spellCheckingType = .no
        tf.keyboardType = .emailAddress
        return tf
    }()
    
    lazy var passwordTextFieldView: UIView = {
        let view = UIView()
        view.frame.size.height = 48
        view.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        view.layer.cornerRadius = 5
        view.clipsToBounds = true
        view.addSubview(passwordTextField)
        view.addSubview(passwordInfoLabel)
        view.addSubview(passwordSecureButton)
        return view
    }()
    
    let passwordInfoLabel : UILabel = {
        let label = UILabel()
        label.text = "비밀번호"
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .white
        return label
    }()
    
    let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.frame.size.height = 48
        tf.backgroundColor = .clear
        tf.textColor = .white
        tf.tintColor = .white
        tf.autocapitalizationType = .none
        tf.autocorrectionType = .no
        tf.spellCheckingType = .no
        tf.isSecureTextEntry = true
        tf.clearsOnBeginEditing = false
        return tf
    }()
    
    let passwordSecureButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("표시", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .light)
        return button
    }()
    
    let loginButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .clear
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        button.layer.borderWidth = 1
        button.layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        button.setTitle("로그인", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.isEnabled = false
        return button
    }()
    
    lazy var stackView : UIStackView = {
        let st = UIStackView(arrangedSubviews: [emailTextFieldView, passwordTextFieldView, loginButton])
        st.spacing = 18
        st.axis = .vertical
        st.distribution = .fillEqually
        st.alignment = .fill
        return st
    }()
    
    private let textViewHeight: CGFloat = 48
    
    let passwordResetButton : UIButton = {
        let btn = UIButton(type: .custom)
        btn.backgroundColor = .clear
        btn.setTitle("비밀번호 재설정", for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        btn.isEnabled = true
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeUI()
    }
    
    func makeUI() {
        
        view.backgroundColor = .black
        
        view.addSubview(stackView)
        view.addSubview(passwordResetButton)
        
        emailInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            emailInfoLabel.leadingAnchor.constraint(equalTo: emailTextFieldView.leadingAnchor, constant: 8),
            emailInfoLabel.trailingAnchor.constraint(equalTo: emailTextFieldView.trailingAnchor, constant: -8),
            emailInfoLabel.centerYAnchor.constraint(equalTo: emailTextFieldView.centerYAnchor, constant: 0),
            
            emailTextField.leadingAnchor.constraint(equalTo: emailTextFieldView.leadingAnchor, constant: 8),
            emailTextField.trailingAnchor.constraint(equalTo: emailTextFieldView.trailingAnchor, constant: -8),
            emailTextField.topAnchor.constraint(equalTo: emailTextFieldView.topAnchor, constant: 15),
            emailTextField.bottomAnchor.constraint(equalTo: emailTextFieldView.bottomAnchor, constant: -2)
        ])
        
        passwordInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordSecureButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            passwordInfoLabel.leadingAnchor.constraint(equalTo: passwordTextFieldView.leadingAnchor, constant: 8),
            passwordInfoLabel.trailingAnchor.constraint(equalTo: passwordTextFieldView.trailingAnchor, constant: -8),
            passwordInfoLabel.centerYAnchor.constraint(equalTo: passwordTextFieldView.centerYAnchor),
            
            passwordTextField.leadingAnchor.constraint(equalTo: passwordTextFieldView.leadingAnchor, constant: 8),
            passwordTextField.trailingAnchor.constraint(equalTo: passwordTextFieldView.trailingAnchor, constant: -8),
            passwordTextField.topAnchor.constraint(equalTo: passwordTextFieldView.topAnchor, constant: 15),
            passwordTextField.bottomAnchor.constraint(equalTo: passwordTextFieldView.bottomAnchor, constant: -2),
            
            passwordSecureButton.centerYAnchor.constraint(equalTo: passwordTextFieldView.centerYAnchor),
            passwordSecureButton.trailingAnchor.constraint(equalTo: passwordTextFieldView.trailingAnchor, constant: -8)
        ])
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            stackView.heightAnchor.constraint(equalToConstant: textViewHeight*3 + 36)
        ])
        
        passwordResetButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            passwordResetButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 10),
            passwordResetButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordResetButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            passwordResetButton.heightAnchor.constraint(equalToConstant: textViewHeight)
        ])
        
    }
}
```

# 세번째 앱 만들기 / 코드 설정하기 - Alert (앱23강)

### Alert

```swift
let alert = UIAlertController(title: "비밀번호 바꾸기", message: "비밀번호를 바꾸시겠습니까?", preferredStyle: .alert)

let success = UIAlertAction(title: "확인", style: .default) { _ in
    print("확인 버튼 눌림")
}
let cancel = UIAlertAction(title: "취소", style: .cancel) { _ in
    print("취소 버튼 눌림")
}

alert.addAction(success)
alert.addAction(cancel)

present(alert, animated: true, completion: nil)
```

- UIAlertController 는 뷰컨을 상속하므로 present 사용가능
    - present 사용하면 화면 전체를 경고창으로 덮인다(그렇게 안보이지만)

### isSecureTextEntry

```swift
passwordTextField.isSecureTextEntry.toggle()
```

- 비밀번호 보이게

# 세번째 앱 만들기 / 코드 설정하기 - 애니메이션 (앱24강)

### 텍스트필드 클릭 감지

```swift
extension ViewController : UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
    }
}
```

### 바꾸고 싶은 값 변경

```swift
lazy var emailInfoLabelCenterYConstraint = emailInfoLabel.centerYAnchor.constraint(equalTo: emailTextFieldView.centerYAnchor, constant: 0)

NSLayoutConstraint.activate([
    emailInfoLabel.leadingAnchor.constraint(equalTo: emailTextFieldView.leadingAnchor, constant: 8),
    emailInfoLabel.trailingAnchor.constraint(equalTo: emailTextFieldView.trailingAnchor, constant: -8),
    **emailInfoLabelCenterYConstraint**
])

extension ViewController : UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == emailTextField {
            emailTextFieldView.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            emailInfoLabel.font = UIFont.systemFont(ofSize: 11)
            emailInfoLabelCenterYConstraint.constant = -13
        }
    }
}
```

→ 동적인 값 변경을 위해서 **`emailInfoLabelCenterYConstraint`** 을 변수로 설정해줌

### 애니메이션 구현

```swift
UIView.animate(withDuration: 0.3) {
    self.view.layoutIfNeeded()
}
```

→ RunLoop 랑 관련이 있다고 하시는데 자세한건 나중에

# 세번째 앱 만들기 / 코드 설정하기 - 로그인 (앱25강)

<aside>
💡 **addTarget ∙ sender ∙ UIControl ∙Selector**

</aside>

### 로그인버튼을 빨갛게

```swift
let emailTextField : UITextField = {
    var tf = UITextField()
    tf.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
    return tf
}()

@objc func textFieldChanged(tf:UITextField){
    if tf.text?.count == 1 {
        if tf.text?.first == " " {
            tf.text = ""
            return
        }
    }
    guard
        let email = emailTextField.text, !email.isEmpty,
        let password = passwordTextField.text, !password.isEmpty
    else {
        loginButton.backgroundColor = .clear
        loginButton.isEnabled = false
        return
    }
    loginButton.backgroundColor = .red
    loginButton.isEnabled = true
}
```

- `**addTarget` 이 사용자의 인터랙션을 감지해서 Target(뷰컨)으로 Action(func) 을 전달한다**
- `**textFieldChanged(tf:UITextField)` 이렇게 써주면 어째서 sender 를 받을 수 있는가 때문에 2시간 소모**
