import UIKit

var greeting = "Hello, playground"

var comChoice : Int = Int.random(in: 1...10)

var myChoice : Int = 5

switch myChoice {
case let x where x < comChoice :
    print("Up")
case let x where x == comChoice :
    print("Bingo")
case let x where x > comChoice :
    print("Down")
default:
    break
}

