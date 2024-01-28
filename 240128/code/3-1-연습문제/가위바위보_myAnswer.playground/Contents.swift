import UIKit

var greeting = "Hello, playground"

// 가위바위보 게임
// 가위 0, 바위 1, 보 2

var rsp : [String] = ["가위", "바위", "보"]

var comChoice : String = rsp[Int.random(in: 0...2)]

var myChoice : String

myChoice = "가위"

if myChoice == "가위" {
    if comChoice == "가위" {
        print("무승부입니다")
    } else if comChoice == "바위" {
        print("당신이 졌습니다")
    } else {
        print("당신이 이겼습니다")
    }
} else if myChoice == "바위" {
    if comChoice == "가위" {
        print("당신이 이겼습니다")
    } else if comChoice == "바위" {
        print("무승부입니다")
    } else {
        print("당신이 졌습니다")
    }
} else {
    if comChoice == "가위" {
        print("당신이 졌습니다")
    } else if comChoice == "바위" {
        print("당신이 이겼습니다")
    } else {
        print("무승부입니다")
    }
}

