//: [Previous](@previous)

import Foundation
import UIKit
import Combine


final class ViewModel {
    @Published var name = "1"
}
class Label {
    var text = "0"
}

let vm = ViewModel()
let label = Label()

print(label.text)
vm.$name.assign(to: \.text, on: label)
print(label.text)
vm.name = "2"
print(label.text)
vm.name = "3"
print(label.text)


//: [Next](@next)
