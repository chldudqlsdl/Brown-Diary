import UIKit

class MyClass {
    var name: String
    
    init(name: String) {
        self.name = name
        print("\(name) 객체가 생성되었습니다.")
    }
    
    deinit {
        print("\(name) 객체가 메모리에서 해제되었습니다.")
    }
}

// 객체 생성
var myObject: MyClass? = MyClass(name: "Example")

// 객체 사용

// 객체를 더 이상 사용하지 않음
myObject = nil
// "Example 객체가 메모리에서 해제되었습니다."가 출력됨

MyClass(name: "Deinit test")
