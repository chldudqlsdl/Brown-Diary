/*:배열*/

// 요소접근
var stringArray = ["Apple", "Swift", "iOS", "Hello"]


print(stringArray[0])
print(stringArray.startIndex)
print(stringArray.firstIndex(of: "Apple"))
print(stringArray[0...1])
var opt = stringArray.startIndex

// 삽입
//var alphabet = ["A", "B", "C", "D", "E", "F", "G"]
//
//alphabet.insert("c", at: 4)
//
//alphabet.insert(contentsOf: ["a","b","c"], at: 0)

// 교체
var alphabet = ["A", "B", "C", "D", "E", "F", "G"]

alphabet[0] = "a"

alphabet[0...2] = ["x", "y", "z"]

alphabet[0...1] = []

alphabet.replaceSubrange(0...2, with: ["a", "b", "c"])

// 추가

// 삭제

// enumerated

var nums = [10, 11, 12, 13, 14]

for tuple in nums.enumerated() {
    print(tuple)
}

/*:딕셔너리*/
var dic = ["A": "Apple", "B": "Banana", "C": "City"]

var nilDic : [String:String] = [:]

var random = dic.randomElement()

// 옵셔널
var value = dic["A"]
print(value)

var def = dic["D", default: "Dance"]

var keys = dic.keys
print(keys)
var nilKeys = nilDic.keys

var sorted = dic.keys.sorted()
print(sorted)

dic["E"] = "Eleven"

dic.updateValue("Fruit", forKey: "F")

/*:세트*/
var mySet: Set = [1, 1, 2, 2, 3, 3, 3]
print(mySet.randomElement())
print(mySet.update(with: 1))
