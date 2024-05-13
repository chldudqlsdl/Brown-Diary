import UIKit

// Struct
struct Album {
    let title : String
    let artist : String
    var isReleased = false
    
    func description() -> String {
        return "\(title) by \(artist)"
    }
    // 구조체 내부 변수 값을 변경할 경우
    mutating func release() {
        isReleased = true
    }
}

var myAlbum = Album(title: "S∙P∙O∙R∙T∙S", artist: "T-SQUARE")
print(myAlbum.description())
print(myAlbum.isReleased)
myAlbum.release()
print(myAlbum.isReleased)

// Class
class Employee {
    var name : String
    var hours : Int
    
    // 생성자를 수동으로 만들어줘야함
    init(name: String, hours: Int) {
        self.name = name
        self.hours = hours
    }
    
    func work() {
        print("I'm working")
    }
}

// Class 상속
class iOSDeveloper: Employee {
    override func work() {
        print("I'm coding")
    }
}

let Brown = iOSDeveloper(name: "Brown", hours: 8)
Brown.work()

// Computed Property
struct Person {
    var firstName : String
    var lastName : String
    var fullName : String {
        return "\(firstName) + \(lastName)"
    }
}
