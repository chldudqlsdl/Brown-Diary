import UIKit

var greeting = "Hello, playground"

// if
let age = 29
if age < 30 {
    print("청춘")
} else {
    print("안청춘")
}

//Switch-enum
enum Weather {
    case sun
    case cloud
    case rain
}

var weather : Weather = .sun

switch weather {
case .sun:
    print("맑아요")
case .cloud:
    print("구름")
case .rain:
    print("비")
}

//for문
let ages = [10, 20, 30]
for age in ages {
    print("age: \(age)")
}

//while
var count = 5
while count > 0 {
    print(count)
    count -= 1
}
