//: [Previous](@previous)

import Foundation
import Combine

var subscriptions = Set<AnyCancellable>()
let subject = PassthroughSubject<Int, Never>()

// The print() operator prints you all lifecycle events -> 신기하다

let subscription = subject
    .print()
    .sink { value in
    print(value)
}
//    .store(in: &subscriptions)
subscription.store(in: &subscriptions)
subject.send(1)
subject.send(2)
subject.send(3)
//업로드취소
//subject.send(completion: .finished)
//구독취소
subscription.cancel()
subject.send(4)



//: [Next](@next)
