import Foundation
// 에러 핸들링

// 에러는 열거형 -> 정의해 줘야함 => 에러 프로토콜 채택

enum SomeError : Error {
    case aError
    case bError
    case cError
}

func doSomething(num: Int) throws -> Bool {
    
    if num >= 7 {
        return true
    } else {
        
        if num < 0 {
            throw SomeError.aError
        }
        
        return false
    }
}

do {
    try doSomething(num: -1)
} catch {
    print("에러입니다")
}

// 에러 처리 방법

let isNotError = try! doSomething(num: 7)
print(isNotError)

// catch 문 다운캐스팅 분기

do {
    try doSomething(num: -1)
} catch {
    print(error)
    
    if let error = error as? SomeError {
        switch error {
        case .aError :
            print("Holy")
        default :
            print("Moly")
        }
    }
}

// 에러 다시 던지기

func errorTest(closure: () throws -> Void) rethrows {
        try closure()
}

do {
    try errorTest {
        throw SomeError.aError
    }
} catch {
    print("확인")
}
