// map 함수

var array = [1, 2, 3, 4, 5]

var newArray = array.map { $0 * 100 }

print(newArray)

// filter 함수

var members = [("브라운", 30),("찰리", 5), ("그레이", 40)]

var newMembers = members.filter { info in
    info.1 < 30
}

print(newMembers)

// reduce

var players = ["이강인", "손흥민", "김민재", "황희찬"]

var winner = players.reduce("황인범") { a, b in
    return [a, b][Int.random(in: 0...1)]
}

print(winner)
