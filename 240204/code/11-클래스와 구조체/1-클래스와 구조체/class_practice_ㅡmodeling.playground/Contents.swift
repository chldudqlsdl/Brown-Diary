
class Book {
    let name : String
    let price : Int
    let company : String
    let author : String
    let pages : Int
    
    init(name: String, price: Int, company: String, author: String, pages: Int) {
        self.name = name
        self.price = price
        self.company = company
        self.author = author
        self.pages = pages
    }
}

var myBook = Book(name: "노인과바다", price: 15000, company: "민음사", author: "어니스트 헤밍웨이", pages: 399)

struct Movie {
    let title : String
    let genre : String
    let actor : String
    let directer : String
}

var movie = Movie(title: "인터스텔라", genre: "SF", actor: "매튜", directer: "논란")
