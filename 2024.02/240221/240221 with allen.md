# GCD사용시 주의해야할 사항 (177강)

<aside>
💡 **URL Loading System 은 비동기적으로 작동합니다**

</aside>

### UI관련 작업은 메인쓰레드에서

```swift
URLSession.shared.dataTask(with: url) { (data, response, error) in
    
    guard let imageData = data else { return }
    
    let photoImage = UIImage(data: imageData)
    
    **// 🎾 이미지 표시는 DispatchQueue.main에서 🎾
    DispatchQueue.main.async {
        imageView?.image = photoImage
    }**
    
}.resume()
```

- 메인쓰레드가 아닌 쓰레드는 UI 업데이트를 할 수 없다

## **비동기 작업의 결과값 얻기 : 컴플리션 핸들러**

### **비동기적인 작업시 메인쓰레드는 작업의 종료를 기다리지 않고 바로 리턴시킨다**

- **URLSession 은 비동기적인 작업이다!!!**
    
    [URLSession | Apple Developer Documentation](https://developer.apple.com/documentation/foundation/urlsession)
    

### 잘못된 방법 : 원하는 값을 리턴

```swift
func getImages(with urlString: String) -> UIImage? {
        
    var photoImage: UIImage? = nil
    
    URLSession.shared.dataTask(with: url) { (data, response, error) in
        if error != nil {
            print("에러있음: \(error!)")
        }

        guard let imageData = data else { return }
        
        photoImage = UIImage(data: imageData)
        
    }.resume()

    return photoImage    // 항상 nil 이 나옴
}

getImages(with: "https://bit.ly/32ps0DI")    // 무조건 nil로 리턴함 ⭐️
```

- **URLSession 은 비동기적인 작업이기에 이 작업을 다른 쓰레드로 보내고 결과를 기다리지 않고 바로 리턴**
    - 무조건 nil로 리턴이 되겠지

### **올바른 방법 : 컴플리션 핸들러(콜백함수)**

```swift
func properlyGetImages(with urlString: String, completionHandler: @escaping (UIImage?) -> Void) {
        
    var photoImage: UIImage? = nil
    
    URLSession.shared.dataTask(with: url) { (data, response, error) in
        if error != nil {
            print("에러있음: \(error!)")
        }
        guard let imageData = data else { return }
        
        photoImage = UIImage(data: imageData)
        
        completionHandler(photoImage)
        
    }.resume()
    
}

// 올바르게 설계한 함수 실행
properlyGetImages(with: "https://bit.ly/32ps0DI") { (image) in
    
    // 처리 관련 코드 
}
```

- **비동기작업(URLSession)도 내부적으로는 동기적으로 동작**
- **그러니 컴플리션 핸들러는 결과값을 받을 수 있음**
    - Swift 에서는 결과값을 받아 나오는 클로저를 컴플리션 핸들러라고들 사용한다
    - 다른 방법은 없는 듯…
    
# **GCD사용시 주의해야할 사항 (weak/strong캡처 주의) (179강)**

### weak, strong 캡처의 주의

```swift
class ViewController: UIViewController {
    
    var name: String = "뷰컨"
    
        **// 강한참조**
    func doSomething() {
        DispatchQueue.global().async {
            sleep(3)
            print("글로벌큐에서 출력하기: \(self.name)")
        }
    }

        **// 약한참조**
        func doSomething() {
        DispatchQueue.global().async { [weak self] in
            guard let weakSelf = self else { return }
            sleep(3)
            print("글로벌큐에서 출력하기: \(weakSelf.name)")
        }
    }
}

func localScopeFunction() {
    let vc = ViewController()
    vc.doSomething()
}

localScopeFunction()
```

- **강한참조 : 이미 vc 는 메모리에서 사라졌지만, self 를 강한 참조하고 있어 `self.name` 을 프린트 해낸다**
- **약한참조 : 뷰컨트롤러를 길게 잡아 둘 필요가 없다면, [weak self] 사용하자**

### 동기 함수를 비동기 함수로 변형하기

```swift
func longtimePrint(name: String) -> String {
    print("프린트 - 1")
    sleep(1)
    print("프린트 - 2")
    sleep(1)
    return "작업 종료"
}

func asyncLongtimePrint(name: String, completion: @escaping (String) -> Void) {
    DispatchQueue.global().async {
        let n = longtimePrint(name: name)
        completion(n)
    }
}
```

**→ 당연한 이야기!**

### Data(contentsOf: url)! → 직접 비동기 처리 해줘야!
