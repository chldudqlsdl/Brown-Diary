import UIKit

protocol Coach {
    var name: String { get }
    var team: String { get set }
    func training()
}

struct footBallCoach: Coach {
    var name: String
    var team: String
    func training() {
        print("Pass Traing")
    }
}

var mourinho = footBallCoach(name: "mourinho", team: "AS Roma")
// 컴파일 오류가 플레이그라운드에서는 나지 않는다..?
mourinho.name = "ferguson"


