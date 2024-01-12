//: [Previous](@previous)

import Foundation
import Combine
import UIKit



// URLSessionTask Publisher and JSON Decoding Operator
// Singleton 
// 아래의 map은 Collection에서 사용하는 map과 다르다

struct SomeDecodable: Decodable {}

URLSession.shared.dataTaskPublisher(for: URL(string: "https://www.google.com")!)
    .map { data, response in
    return data
}
    .decode(type: SomeDecodable.self, decoder: JSONDecoder())

// Notifications
let center = NotificationCenter.default
let noti = Notification.Name("MyNoti")
let notiPublisher = center.publisher(for: noti, object: nil)
let subscription1 = notiPublisher.sink { _ in
    print("Noti Received")
}
center.post(name: noti, object: nil)
subscription1.cancel()

// KeyPath binding to NSObject instances

let label = UILabel()
print(label.text)

Just(28)
    .map {"\($0)"}
    .assign(to: \.text, on: label)
print(label.text)


// Timer
// autoconnect 를 이용하면 subscribe 되면 바로 시작함

let timePublisher = Timer
    .publish(every: 1, on: .main, in: .common)
    .autoconnect()

let subcription2 = timePublisher.sink { time in
    print(time)
}

DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
    subcription2.cancel()
}

//: [Next](@next)
