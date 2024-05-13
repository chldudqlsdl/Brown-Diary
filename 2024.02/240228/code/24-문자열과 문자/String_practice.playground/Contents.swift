import Foundation

var someString = "한"

for i in someString.utf8 {
    print(i.self)
    print()
}

for i in someString.unicodeScalars {
    print(i.value)
    print()
}
