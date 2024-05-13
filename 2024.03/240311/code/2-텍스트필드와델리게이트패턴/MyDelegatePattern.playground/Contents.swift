import UIKit

protocol DeveloperDelegate {
    func coding()
    func coffeeChat()
}

class Company {
    let name : String = "Naver"
    
    var delegate : DeveloperDelegate?
    
    func coding() {
        delegate?.coding()
    }
    
    func coffeeChat() {
        delegate?.coffeeChat()
    }
}

class Human: DeveloperDelegate {
    let name : String = "Brown"
    
    func coding() {
        print("코딩중")
    }
    
    func coffeeChat() {
        print("잡담중")
    }
}

let brown = Human()

let naver = Company()

naver.delegate = brown

naver.coding()
naver.coffeeChat()
