import Foundation
import Combine

//Subject는 Combine에서 Publisher와 Subcriber 역할을 동시에 한다

// PassthroughSubject
let passthrough = PassthroughSubject<String, Never>()
let subscription1 = passthrough.sink { value in
    print(value)
}
passthrough.send("Here")
passthrough.send("We")

// CurrentValueSubject
var currentvalue = CurrentValueSubject<String, Never>("Hello")
let subscription2 = currentvalue.sink { value in
    print(value)
}
//currentvalue.send("Bye")

//동시타
let publisher = ["go", "!"].publisher
publisher.subscribe(passthrough)






