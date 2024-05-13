import Foundation

var someString = "뷁"

for i in someString.unicodeScalars {
    print(i.value)
    print()
}

var myString = """
"" Hello ""
"""

print(myString)
