
/*:열거형*/
enum BigTech {
    case microsoft
    case apple
    case google
    case amazon
}

var company1 : BigTech = BigTech.apple
var company2 : BigTech = .google
/*:원시값과 연관값*/
// 원시값

enum Direction : Int {
    case east
    case west = 2
    case south
    case north
}

var east : Direction? = Direction(rawValue: 0)
//var west : Direction = Direction(rawValue: 1)!
var num : Int = Direction.south.rawValue

//연관값

enum Computer {
    case cpu(core: Int, ghz: Double)
    case ram(Int, String)
    case hardDisk(gb: Int)
}

var myChip1 = Computer.cpu(core: 8, ghz: 3.5)
var myChip2 = Computer.ram(16, "DRAM")
var myChip3 = Computer.hardDisk(gb: 256)

// 연관값 활용
var chip = Computer.cpu(core: 8, ghz: 2.0)

switch chip {
case .cpu(core: 8, _):
    print("CPU 8코어 3.1GHz입니다.")
default:
    print("그 이외의 칩에는 관심이 없습니다.")
}

// 연관값을 가진 케이스를 패턴 매칭시키기

switch chip {
case .cpu(let a, let b):    // let a = 연관값, let b = 연관값
    print("CPU \(a)코어 \(b)GHz입니다.")
case let .ram(a, _):
    print("램 \(a)기가램 입니다.")
case let .hardDisk(a) :
    print("하드디스크 \(a)기가 용량입니다.")
}

/*:옵셔널타입에 대한 정확한 이해*/
// 옵셔널의 내부구현
//enum Optional<Wrapped> {
//    case some(Wrapped)
//    case none
//}

enum Optional {
    case some(Int)
    case none
}

var some : Optional = Optional.some(7)
var none : Optional = Optional.none

// 7을 어떻게 꺼내지?
switch some {
case .some(let a) :
    print(a)
case .none :
    print("nil")
}

/*:열거형과 switch문*/
// 옵셔널 열거형 (연관값이 없는)
enum SomeEnum {
    case left
    case right
}

var leftRight : SomeEnum? = .left

switch leftRight {
case .some(let direction) :
    switch direction {
    case .left :
        print("left")
    case .right :
        print("right")
    }
case .none :
    print("방향없음")
}

switch leftRight {
case .left :
    print("left")
case .right :
    print("right")
case nil :
    print("방향없음")
}

//연관값 있는 열거형
enum MyComputer {
    case cpu(core: Int)
    case hard(core: Int)
}

var myChip : MyComputer = .hard(core: 4)

switch myChip {
case .cpu(core: let num) :
    print(num)
default:
    break
}

if case let .cpu(num) = myChip{
    print(num)
} else {
    print("sad")
}

// 옵셔널 패턴

var myOptional : Int? = 7

switch myOptional {
case .some(let x) :
    print(x)
case .none :
    print("nil")
}

switch myOptional {
case let x? :
    print(x)
case nil :
    print("nil")
}
