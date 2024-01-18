//: [Previous](@previous)

import Foundation
import Combine

struct MyPublisher: Publisher {
    // Output: 발행되는 값의 형식
    // Failure: 에러의 형식 (Swift의 Error 프로토콜을 채택하는 형식)
    typealias Output = String
    typealias Failure = Never // 에러가 발생하지 않는 경우

    // Subscriber에게 값을 전달하는 메서드
    func receive<S>(subscriber: S) where S : Subscriber, Failure == S.Failure, Output == S.Input {
        // 실제로 값이 전달되는 부분
        let subscription = MySubscription(subscriber: subscriber)
        subscriber.receive(subscription: subscription)
    }
}

// Subscription을 정의하는 예제
class MySubscription<S: Subscriber>: Subscription where S.Input == String, S.Failure == Never {
    private var subscriber: S?

    init(subscriber: S) {
        self.subscriber = subscriber
    }

    // Subscriber에게 값을 전달하고 완료된 상태를 알림
    func request(_ demand: Subscribers.Demand) {
        // 실제로 값을 전달하는 부분
        _ = subscriber?.receive("Hello, Combine!")
        subscriber?.receive(completion: .finished)
    }

    // Subscription을 취소하고 자원을 정리
    func cancel() {
        subscriber = nil
    }
}

// 사용 예제
let myPublisher = MyPublisher()

// Combine을 사용하여 값을 받아오는 Subscriber를 정의
let mySubscriber = Subscribers.Sink<String, Never>(
    receiveCompletion: { completion in
        switch completion {
        case .finished:
            print("Subscription finished.")
        }
    },
    receiveValue: { value in
        print("Received value: \(value)")
    }
)

// Publisher에 Subscriber를 연결하고 값을 받아오기 시작
myPublisher.subscribe(mySubscriber)

//: [Next](@next)
