import UIKit

// 익스텐션
// 기존 타입에 새로운 역할(기능 및 속성) 추가하고 싶을 때 사용
extension String {
    func contains(s: String) -> Bool {
        return (self.range(of: s) != nil)
    }
}

let testString = "Hello iOS Developer"
print(testString.contains(s: "iOS"))
