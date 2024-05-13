//: [Previous](@previous)

import Foundation
import Combine


// Basic CombineLatest

let strPublisher = PassthroughSubject<String, Never>()
let intPublisher = PassthroughSubject<Int, Never>()

//CombinerLastest는 두가지 형태로 사용
//Publishers.CombineLatest(strPublisher, intPublisher)
//    .sink { (str, int) in
//        print("str : \(str) , int : \(int)")
//    }
strPublisher.combineLatest(intPublisher)
    .sink { (String, Int) in
    print("str : \(String) , int : \(Int)")
}

strPublisher.send("가")
intPublisher.send(1)
intPublisher.send(2)
strPublisher.send("나")
intPublisher.send(3)
strPublisher.send("다")


// Advanced CombineLatest

let idPublisher = PassthroughSubject<String,Never>()
let passwordPublisher = PassthroughSubject<String,Never>()

idPublisher.combineLatest(passwordPublisher)
    .map { (id, pw) -> Bool in
        return !id.isEmpty && pw.count > 7 }
    .sink { value in
        print(value)
    }

idPublisher.send("chldudqlsdl")
passwordPublisher.send("1111")
passwordPublisher.send("12345678")

// Merge

let publisher1 = [1, 2, 3, 4, 5].publisher
let publisher2 = [100, 200, 300].publisher

let mergedPublisher = publisher1.merge(with: publisher2)
    .sink { value in
        print(value)
    }


//: [Next](@next)

