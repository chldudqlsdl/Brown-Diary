import Foundation
import Combine

//Subject는 Combine에서 Publisher와 Subcriber 역할을 동시에 한다

// PassthroughSubject
let passthrough = PassthroughSubject<String, Never>()
passthrough
    .sink { value in
    print(value)
}
passthrough.send("Here")
passthrough.send("We")

// CurrentValueSubject
var currentvalue = CurrentValueSubject<String, Never>("Hi")
currentvalue
    .sink { value in
    print(value)
}
currentvalue.send("Bye")

//동시타
let publisher = ["!"].publisher
publisher.subscribe(passthrough)






