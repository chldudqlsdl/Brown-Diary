import UIKit

func travel(num : Int , action : (Int) -> Void ) {
    print("Hi")
    action(num)
    print("Bye")
}

travel(num: 2) { int in
    print(int)
}

travel(num: 3) { int in
    print(int*2)
}

var greeting = "Hello, playground"
