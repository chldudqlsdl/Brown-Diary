# 복습3

### 에러 처리 방법 (164강)

- try?
    
    ```swift
    let isChecked = try? checkingHeight(height: 200)
    ```
    
- catch 블럭 처리
    
    ```swift
    do {
        let isChecked = try checkingHeight(height: 100)
        
    } catch {    // error 상수를 제공 (모든 에러가 넘어옴)
        print(error.localizedDescription)
        
        if let error = error as? HeightError {    // 실제 우리가 정의한 구체적인 에러 타입이 아니고, 에러 타입(프로토콜)이 넘어올 뿐
            switch error {
            case .maxHeight:
                print("키가 커서 놀이기구 타는 것 불가능")
            case .minHeight:
                print("키가 작아서 놀이기구 타는 것 불가능")
            }
        }
    }
    ```
    

### 에러를 던지는 함수를 처리하는 함수 (165강)

- throwing함수로 에러 다시 던지기 : 함수 내에서 에러 처리를 직접 못하는 경우
    
    ```swift
    func handleError1() throws {
        //do {
        try throwingFunc()
        //}                     // catch블럭이 없어도 에러를 밖으로 던질 수 있음 ⭐️
    }
    
    do {
        try handleError1()   // 에러를 받아서 처리 가능
    } catch {
        print(error)
    }
    ```
    
- **rethrowing함수로 에러 다시 던지기 : throwing 함수를 파라미터로 받는 경우**
    
    ```swift
    // 다시 에러를 던지는 함수(방법1)
    func someFunction1(callback: () throws -> Void) rethrows {
        try callback()             // 에러를 다시 던짐(직접 던지지 못함)
        // throw (X)
    }
    
    do {
        try someFunction1(callback: throwingFunc)
    } catch {
        print(error)
    }
    ```
    

### iOS에서의 네트워킹 (169강)

```swift
// 0. URL주소 : 문자열
let movieURL = "http://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?&key=⭐️본인들각자의키값입력⭐️&targetDt=20210201"

// 1. URL 구조체 만들기 : 없는 URL 일 수도 있으니 옵셔널임
let url = URL(string: movieURL)!

// 2. URLSession 만들기 : 싱글톤
let session = URLSession.shared

// 3. 세션에 작업 부여 : 일시정지 상태
let task = session.dataTask(with: url) { (data, response, error) in

        // 관습적으로 error 를 먼저 검증 -> 에러 나오면 바로 중단하도록
    if error != nil {
        print(error!)
        return
    }
    
    guard let safeData = data else {
        return
    }
    
    // 데이터를 그냥 한번 출력
    print(String(decoding: safeData, as: UTF8.self))
}

// 4.작업시작
task.resume()
```

### JSON Parsing (171강)

```swift
func parseJSON(_ movieData: Data) -> [DailyBoxOfficeList]? {
    
    do {

        let decoder = JSONDecoder()
        
        let decodedData = try decoder.decode(MovieData.self, from: movieData)

        return decodedData.boxOfficeResult.dailyBoxOfficeList
        
    } catch {
   
        return nil
    }
}
```

### 동시성(Concurrency) 프로그래밍 (173강)

- 기본 원리
    - 메인쓰레드는 화면 업데이트 수행 (바쁘다) → 시간이 오래 걸리는 작업은 다른 쓰레드에 맡기자
    큐(디스패치 큐) 로 작업을 보내면 여러 쓰레드로 알아서 작업을 나눠준다
- 병렬 ∙ 동시
    - 병렬 : 물리적으로 여러 쓰레드로 나눠서 작업을 처리
    - 동시 : 소프트웨어적으로 여러 쓰레드로 나눠서 작업을 처리

### 동기 비동기의 개념 (174강)

- 동기 : 다른 쓰레드로 보낸 작업을 기다린다
- 비동기 : 다른 쓰레드로 보낸 작업을 기다리지 않는다

### 직렬과 동시의 개념 (175강)

- 직렬 : 메인에서 분산시킨 작업을 다른 한개의 쓰레드에서 처리하는 큐
- 동시 : 메인에서 분산시킨 작업을 다른 여러개의 쓰레드에서 처리하는 큐

### GCD의 개념 및 종류 (176강)

- 메인큐
    
    ```swift
    let mainQueue = DispatchQueue.main
    ```
    
- 글로벌 큐 → 다양한 설정 가능
    
    ```swift
    let defaultQueue = DispatchQueue.global()
    ```
    
- 프라이빗 큐
    
    ```swift
    let privateQueue = DispatchQueue(label: "com.inflearn.serial")
    ```
    

### GCD사용시 주의해야할 사항 (177강)

<aside>
💡 **URL Loading System 은 비동기적으로 작동합니다**

</aside>

- **UI관련 작업은 메인쓰레드에서**
    
    ```swift
    URLSession.shared.dataTask(with: url) { (data, response, error) in
        
        **// 🎾 이미지 표시는 DispatchQueue.main에서 🎾
        DispatchQueue.main.async {
            imageView?.image = photoImage
        }**
        
    }.resume()
    ```
    
- **비동기 작업의 결과값 얻기 : 컴플리션 핸들러**
    
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
    ```
    

### Async/await의 도입 / 스위프트 5.5이후 (180강)

- 기존
    
    ```swift
    func longtimePrint(completion: @escaping (Int) -> Void) {
        DispatchQueue.global().async {
            print("프린트 - 1")
            sleep(1)
            print("프린트 - 2")
            sleep(1)
            completion(7)
        }
    }
    
    func linkedPrint(completion: @escaping (Int) -> Void) {
        longtimePrint { num in
            // 코드처리
            longtimePrint { num in
                // 코드처리
                completion(num)    // 모든 비동기함수의 종료시점을 알려줌
            }
        }
    }
    ```
    
- Async/await
    
    ```swift
    func longtimeAsyncAwait() async -> Int {
        print("프린트 - 1")
        sleep(1)
        print("프린트 - 2")
        sleep(1)
        return 7
    }
    
    func linkedPrint2() async -> Int {
        _ = await longtimeAsyncAwait()
        _ = await longtimeAsyncAwait()
        return 7
    }
    ```
    

### 제네릭 문법의 필요성 (183강)

- 제네릭 정의
    
    ```swift
    func printArray<T>(array: [T]) {
        for element in array {
            print(element)
        }
    }
    ```
    

