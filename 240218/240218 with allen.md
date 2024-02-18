# 에러 처리 문법 (163강)

### 개념

**(함수처리 과정에서) 예상치 못한 크래시 방지 (런타임 에러)**

## 에러 처리의 3단계

### 에러 정의

```swift
enum HeightError: Error {    //에러 프로토콜 채택 (약속)
    case maxHeight
    case minHeight
}
```

- **열거형으로 정의한다**
- `**Error` 프로토콜을 채택해줘야 한다.**

### 에러 발생 함수 정의

```swift
func checkingHeight(height: Int) throws -> Bool {    // (에러를 던잘수 있는 함수 타입이다)
    
    if height > 190 {
        throw HeightError.maxHeight
    } else if height < 130 {
        throw HeightError.minHeight
    } else {
        return true
    }
}
```

- **파라미터 뒤에 throws 를 붙여주면 ⇒ 에러를 던질수 있는 함수 타입이다라는 뜻**
- **에러를 리턴할 때는 return 이 아니라 throw 를 사용한다**

### 에러 발생 함수 실행

```swift
do {
    let isChecked = try checkingHeight(height: 200)
    print("놀이기구 타는 것 가능: \(isChecked)")
    
} catch {
    print("놀이기구 타는 것 불가능")
}
```

- **에러를 발생시키는 함수 앞에는 꼭 try 를 적어줘야 한다**
- **그리고 try 는 에러 핸들링을 위해서는 do - catch 문과 함께 사용되어야 한다**
    - **do : 에러가 아닐 경우 실행되는 블럭**
    - **catch : 에러일 경우 실행되는 블럭**

### 알고보면

```swift
[1, 2, 3, 4, 5].map(transform: (Int) throws -> T)
```

- map 도 에러발생 가능 클로저를 파라미터로 받고 있었다
    - 근데 try 같은 건 써준 적이 없었는데… ⇒ 아 try는 구현부에 있구나!

# 에러 처리 방법 (164강)

## 에러 처리 방법

### try(기본)

```swift
do {
    let isChecked = try checkingHeight(height: 200)
} catch {
    print("놀이기구 타는 것 불가능")
}
```

### try?(개굴)

```swift
let isChecked = try? checkingHeight(height: 200)
```

- **에러가 아닌 경우 → (옵셔널) 리턴타입 ⇒ 언래핑**
- **에러 발생 → nil 리턴**

### try!(무식)

```swift
let isChecked2: Bool = try! checkingHeight(height: 150)
```

- 에러가 아닌 경우 → 리턴타입
- 에러 발생 → 런타임 에러…

## catch 블럭 처리법

### 패턴을 모두 정의

```swift
do {
    let isChecked = try checkingHeight(height: 100)

} catch HeightError.maxHeight  {    // where절을 추가가능
    print("키가 커서 놀이기구 타는 것 불가능")
    
} catch HeightError.minHeight {      // 생략가능
    print("키가 작아서 놀이기구 타는 것 불가능")
    
}
```

- 모두 Error 케이스 정의하거나
- 마지막에 케이스 안적으면, 나머지 녀석들 다 들어온다 (switch의 default 역할)

### 패턴없이 에러 받아서 처리

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

- **catch 블럭 내에서 Error 프로토콜을 따르는 error 상수를 제공**
    - localizedDescription 자주 붙임
- **error 상수를 내가 정의한 에러 타입으로 타입캐스팅**
- **이후 스위치문으로 분기**

### 나열도 가능

```swift
do {
    let isChecked = try checkingHeight(height: 100)

} catch HeightError.maxHeight, HeightError.minHeight {   // 케이스 나열도 가능해짐
    
    print("놀이기구 타는 것 불가능")
}
```

# 에러를 던지는 함수를 처리하는 함수 (165강)

## 함수속에 에러를 던지는 함수가 있다면

### 일반적인 경우

```swift
enum SomeError: Error {
    case aError
}

func throwingFunc() throws {
    throw SomeError.aError
}

do {
    try throwingFunc()
} catch {
    print(error)
}

func handleError() {
    do {
        try throwingFunc()
    } catch {
        print(error)
    }
}
```

### throwing함수로 에러 다시 던지기 : 함수 내에서 에러 처리를 직접 못하는 경우

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

### rethrowing함수로 에러 다시 던지기 : throwing 함수를 파라미터로 받는 경우

```swift
// 다시 에러를 던지는 함수(방법1)
func someFunction1(callback: () throws -> Void) rethrows {
    try callback()             // 에러를 다시 던짐(직접 던지지 못함)
    // throw (X)
}

// 실제 에러를 다시던지는(rethrowing)함수를 처리하는 부분
do {
    try someFunction1(callback: throwingFunc)
} catch {
    print(error)
}

// 다시 에러를 던지는 함수(방법2) - 에러변환
func someFunction2(callback: () throws -> Void) rethrows {
    enum ChangedError: Error {
        case cError
    }
    
    do {
        try callback()
    } catch {   // catch구문에서는 throw (O)
        throw ChangedError.cError    // 에러를 변환해서 다시 던짐
    }
}

// 처리
do {
    try someFunction2(callback: throwingFunc)
} catch {
    print(error)
}
```


