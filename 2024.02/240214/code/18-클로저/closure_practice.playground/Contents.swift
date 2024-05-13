
// 함수는 일급 객체이다 -> 변수에 저장할 수 있다

//func love(name : String , mark: String) -> String {
//    return "I love \(name + mark)"
//}
//
//let loveLetter = love
//
//loveLetter("brown", "!")

let loveLetter = {(name : String , mark: String) -> String in
    return "I love \(name + mark)"
}

// 클로저의 형태

let closure1 = { (a, b: String) in
    return a + "!"
}

closure1("hi", "brown")

// 클로저를 사용하는 이유 : 클로저는 왜 이름이 필요없는가? -> 함수를 실행할 때 전달하는 형태로 사용하기에 이름이 필요없음

func closureNoNeedName(closure : () -> ()) {
    print("클로저는 이름이 필요없다")
    closure()
}

let myClosure : () -> () = { () -> () in
    print("I don't hava a name")
}

closureNoNeedName(closure: myClosure)
closureNoNeedName {
    print("I don't hava a name")
}

// 사용이유 2 : 클로저를 정의하면서 바로 파라미터로 전달 가능하기에 자유도가 높아요

// 최적화 시범

// 캡처현상



let closure = { (num : Int) -> Int in
    var stored = 0
    stored += num
    return stored
}

closure(5)
closure(5)
closure(5)
closure(5)


//func funcClosure(num: Int) -> Int {
//    stored += num
//    return stored
//}
//
//funcClosure(num: 5)
//funcClosure(num: 5)
//funcClosure(num: 5)
//funcClosure(num: 5)


func doSomething() {
    var num: Int = 0
    print("num check #1 = \(num)")
    
    func closure() {
        print("num check #3 = \(num)")
    }
    
    num = 20
    print("num check #2 = \(num)")
    closure()
}

doSomething()
