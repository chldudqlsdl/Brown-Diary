//: [Previous](@previous)

import Foundation
import Combine

//struct PracPublisher : Publisher {
//    typealias Output = Int
//    
//    typealias Failure = Never
//    
//    func receive<S>(subscriber: S) where S : Subscriber, Never == S.Failure, Int == S.Input {
//    }
//}

let pracPublisher = [1, 2, 3, 4, 5].publisher

class PracSubscriber : Subscriber {
    typealias Input = Int
    typealias Failure = Never
    
    func receive(subscription: Subscription) {
        subscription.request(.max(3))
    }
    
    func receive(_ input: Int) -> Subscribers.Demand {
        print(input)
        return .none
    }
    
    func receive(completion: Subscribers.Completion<Never>) {
        print(completion)
    }
}

let pracSubscriber = PracSubscriber()
pracPublisher.subscribe(pracSubscriber)


//: [Next](@next)
