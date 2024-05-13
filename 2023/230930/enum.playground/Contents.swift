import UIKit

// 기본 enum (Raw Value 없음)

enum WeekDay {
    case mon
    case tue
    case wed
}

var today: WeekDay = .mon
print(today)

// enum (Raw Value 있음)
enum Num : Int {
    case mon
    case tue
    case wed
}

var num: Num = .mon
print(num.rawValue)

// 연관값 enum (Associated Value)
enum MediaType {
    case audio(String)
    case video(String)
}

var mp3: MediaType = .audio("mp3")
