//: [Previous](@previous)

import Foundation
import Combine

let subject = PassthroughSubject<Int, Never>()

// The print() operator prints you all lifecycle events -> 신기하다

let subcription = subject
    .print()
    .sink { value in
    print(value)
}
subject.send(1)
subject.send(2)
subject.send(3)
//업로드취소
//subject.send(completion: .finished)
//구독취소
//subcription.cancel()
subject.send(4)



//: [Next](@next)
