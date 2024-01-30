import UIKit

// 문자열 중에 한글자 랜덤 뽑기

func randomOneLetter(word : String) -> String {
    return String(word.randomElement()!)
}

randomOneLetter(word: "브라운")


// 소수 판별하는 함수

var num = 97

var isPrime = true

for i in 2...num {
    if num % i == 0 {
        isPrime = false
        break
    }
}

if isPrime {
    print("소수입니다")
} else {
    print("소수가 아닙니다")
}

// 팩토리얼 함수 만들기

func factorial(_ num : Int) -> Int {
    
    guard num != 0 else { return 0 }
    
    var result = 1
    for i in 1...num {
        result *= i
    }
    return result
}


factorial(10)

// 재귀함수로 만들기

func recursionFactorial(num : Int) -> Int {
    if num <= 1 {
        return 1
    }
    return num * recursionFactorial(num : num - 1)
}

recursionFactorial(num: 10)


