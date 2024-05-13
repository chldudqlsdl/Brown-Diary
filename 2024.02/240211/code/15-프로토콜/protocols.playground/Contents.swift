
// 저장속성 테스트


// get set

protocol MyProtocol {
    static var me : String { get }
}


class Test : MyProtocol {
    class var me : String {
        get { return "brown" }
        set {}
    }
}

class BabyTest : Test {
    override class var me: String {
        get { return "brown2" }
        set {}
    }
}

Test.me
BabyTest.me

// 프로토콜 서브스크립트 요구사항
protocol DataList {
    subscript(idx: Int) -> Int { get }     // (서브스크립트 문법에서) get 필수 (set 선택)
}



struct DataStructure: DataList {
    
//    subscript(idx: Int) -> Int {    // 읽기 전용 서브스크립트로 구현한다면
//        get {
//            return 0
//        }
//    }
    
    subscript(idx: Int) -> Int {    // (최소한만 따르면 됨)
        get {
            return 0
        }
        set {                 // 구현은 선택
            // 상세구현 생략
        }
    }
}

DataStructure()[0]

// 프로토콜은 타입이다

protocol Remote {
    func turnOn()
    func turnOff()
}


class TV: Remote {
    func turnOn() {
        print("TV켜기")
    }
    
    func turnOff() {
        print("TV끄기")
    }
    
    func doNetflix() {
        print("넷플릭스 하기")
    }
}

var tv : Remote = TV()

//tv.doNetflix()

// 어트리뷰트 키워드

func doSomething(completion: @escaping () -> ()){
    
}

// 프로토콜 확장
protocol Remotee {
    func turnOn()
    func turnOff()
}

extension Remotee {                         // (요구사항의 메서드 우선순위 적용 - 프로토콜 메서드 테이블 만듦)
    func turnOn() { print("리모콘 켜기") }    // 1. (채택)구현시 해당 메서드 2. 기본 메서드
    func turnOff() { print("리모콘 끄기") }   // 1. (채택)구현시 해당 메서드 2. 기본 메서드
    
    func doAnotherAction() {               // (요구사항 메서드 X - 테이블 만들지 않음)
        print("리모콘 또 다른 동작")            // 타입에 따른 선택 (Direct Dispatch)
    }
}

class TV1: Remotee {
    //func turnOn() { print("리모콘 켜기") }
    //func turnOff() { print("리모콘 끄기") }
}

TV1().turnOn()
