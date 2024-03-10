# 앱 만들기는 어떤방식으로 접근해야할까 / 노션 활용 (앱6강)

<aside>
💡 **이론에 집착하지 말고 결과를 만드는데 집중할 것**

</aside>

### 앱 만들기 접근법

- 구글 검색
    - 문장 + 키워드 + 언어
        - 코드로 구현시 : programmatically
    - 스택오버플로우
- 공식문서

### 마음가짐

- **Cheat Sheet → Notion**
- **코드를 검색해서 붙여넣어 사용하는 것은 당연하다 → 죄책감 가질 필요없음**
- **하지만 어느정도 익숙해질 때 까지는 무한 반복 연습 → 안보고 만들기**
- **좋은 코드 나쁜 코드 집착하지 말고 일단 완성해라**
- **디테일, 이해에 집착하면 너무 지치니 전체적인 결과물을 만들어 내는 것에 집중하자**

# 첫번째 앱 만들기 / 코드 설정하기 (앱10강)

```swift

class ViewController: UIViewController {

    @IBAction func startButtonTapped(_ sender: UIButton) {
        
        // 1초마다 슬라이더가 한 칸씩 내려가기
                
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [self] timer in
            
            if seconds > 0 {
                seconds -= 1
                mainLabel.text = "\(seconds)"
                slider.value = Float(seconds) / Float(60)
                
            } else {
                timer.invalidate()
            }
        }
    }
}

```

→ [self] 써주면 클로저 내의 변수들에 self 안붙여 줘도 됨

# 첫번째 앱 만들기 / 코드 설정하기 (앱11강)

### 강한참조순환 발생할 뻔?

```swift
import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    weak var timer : Timer?
    
    @IBAction func startButtonTapped(_ sender: UIButton) {
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [self] _ in
            
                seconds -= 1
            
    }
}
```

- ViewController 의 인스턴스가 힙에 올라감  → **Timer 인스턴스를 약하게 가리킴**
- Timer 의 인스턴스가 힙에 올라감  → 클로저를 강하게 가리킴
- 클로저가 힙에 올라감  → 뷰컨 인스턴스를 강하게 가리킴
- `**weak var timer : Timer?` 로 약한 참조를 하지 않으면 삼각?강한순환참조 일어날 뻔**

### Timer : selector 방식

```swift
    // 스타트버튼을 누르면 실행하는 함수
    @IBAction func startButtonTapped(_ sender: UIButton) {
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(doSomethingAfter1Second), userInfo: nil, repeats: true)
    }
    
    // 다음 동작의 실행 함수
    @objc func doSomethingAfter1Second() {
        if number > 0 {
            number -= 1
            print(Float(number) / Float(60))
            slider.value = Float(number) / Float(60)
            mainLabel.text = "\(number) 초"
        } else {
            mainLabel.text = "초를 선택하세요"
            number = 0
            //print(number)
            timer?.invalidate()
            AudioServicesPlaySystemSound(SystemSoundID(1000))
        }
    }
```

