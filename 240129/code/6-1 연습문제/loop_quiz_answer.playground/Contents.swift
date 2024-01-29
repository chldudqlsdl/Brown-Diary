import UIKit

// 구구단

for i in 2...9 {
    for j in 1...9 {
        print("\(i) X \(j) = \(i*j)")
    }
}


// 3의 배수 구하기

for i in 1...100 {
    if i % 3 == 0 {
        print("3의 배수 발견 : \(i)")
    }
}

// 이모지 출력하기

for i in 1...5 {
    for j in 1...5 {
        if i == j {
            print("😁")
            break
        } else {
            print("😁", terminator: "")
        }
    }
}
