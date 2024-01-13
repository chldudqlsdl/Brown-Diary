//: [Previous](@previous)

import Foundation

class Dog {
    var name = "초코"
   
    var run: (() -> Void)?
    
    func walk() {
        print("\(self.name)가 걷는다.")
    }
    
    func saveClosure() {
        // 클로저를 인스턴스의 변수에 저장
        run = {
            print("\(self.name)가 뛴다.")
        }
    }
    
    deinit {
        print("\(self.name) 메모리 해제")
    }
}

//func doSomething() {
//    let choco: Dog? = Dog()
//    choco?.saveClosure()  // 메모리해제 되지않음
//}
//
//doSomething()
var choco : Dog? = Dog()
choco?.saveClosure()
//choco.name
choco = nil

//: [Next](@next)
