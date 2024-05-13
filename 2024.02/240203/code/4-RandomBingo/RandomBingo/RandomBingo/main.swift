//
//  main.swift
//  RandomBingo
//
//  Created by Youngbin Choi on 2/3/24.
//

import Foundation

var answer = Int.random(in: 1...100)

var myChoice = 0

while true {
    
    var userInput = readLine()
    
    if let input = userInput {
        if let number = Int(input) {
            myChoice = number
        }
    }
    
    if answer > myChoice {
        print("Up")
    } else if answer < myChoice {
        print("Down")
    } else {
        print("Bingo")
        break
    }
}
