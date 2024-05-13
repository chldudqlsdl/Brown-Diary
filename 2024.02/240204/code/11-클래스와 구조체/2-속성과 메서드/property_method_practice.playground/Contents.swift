// 저장 속성
func howMuch() -> Int {
    return 5000
}

class Book {
    var price = howMuch()
}

var book = Book()
book.price

// 지연 저장 속성에 기본값이 없다면
// 오류가 난다 -> Lazy properties must have an initialize

//class Movie {
//    lazy var title
//}

