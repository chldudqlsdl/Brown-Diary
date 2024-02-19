# iOS에서의 네트워킹 (169강)

<aside>
💡 **외울 필요 없음 복붙해서 사용하면 된다. 마치 UIButton 처럼, 그런데 이해는 해야겠지?**

</aside>

### iOS 데이터 요청의 4단계

1. **URL 구조체** : 요청할 주소
2. **URLSession** : 네트워킹 담당(브라우저 같은 역할)
    - 뜻풀이 : **일정 시간 동안 같은 브라우저로부터 들어오는 연결 상태를 일정하게 유지시키는 기술**
        - session - 시간 / 기간
3. **dataTask** : 작업 부여(URL 입력)
4. **resume** : press Enter key

### 실사용

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

- **응답 데이터는 JSON 형태이며 차후 이를 디코딩 해줘야함**

### dataTask 구조가 이해가 안 된다면

```swift
// 정의문
open func dataTask(with request: URLRequest,
completionHandler: @escaping @Sendable (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask

// 실행문
session.dataTask(with: URL) { data, response, error in
    code
}

**// 똑같은 구조**

// 정의문
func doSomething(num : Int, completion: (Int) -> Void) {
    let n = num + 5
    completion(n)
}

// 실행문
doSomething(num: 2) { n in
   print(n)
}
```

### 최대한 짧게

```swift
URLSession.shared.dataTask(with: url) { (data, response, error) in
    if error != nil {
        print(error!)
        return
    }
    
    guard let safeData = data else {
        return
    }
    
    print(String(decoding: safeData, as: UTF8.self))

}.resume()
```

# JSON Parsing (171강)

### JSON의 구조가 나타난 지도

[Instantly parse JSON in any language | quicktype](https://app.quicktype.io/)

```swift
struct MovieData: Codable {
    let boxOfficeResult: BoxOfficeResult
}

struct BoxOfficeResult: Codable {
    let dailyBoxOfficeList: [DailyBoxOfficeList]
}

// 실질적으로 원하는 정보는 여기 들어있다
struct DailyBoxOfficeList: Codable {
    let rank: String
    let movieNm: String
    let audiCnt: String
    let audiAcc: String
    let openDt: String
}
```

### Decode : 지도를 통해 원하는 곳으로 데려다줘

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

- try 가 붙은 이유 : `decode` 메서드는 `throws` 가 적힌 에러를 던질 수 있는 메서드
- `MovieData.self` 반드시 Decodable 프로토콜을 준수하는 타입이어야 한다
    - MovieData 는 Codable 프로토콜을 준수하고 있다 (Codable은 Enco, Deco 둘다 커버)
- `parseJSON` 함수는 옵셔널 값을 리턴합니다
    - docode 에러나면 nil을 리턴하니까
- `dump( )` : 복잡한 데이터 구조나 객체를 살펴보거나 디버깅할 때 보기 편하게 프린트
