import Foundation

// Date
let now = Date()

now

let interval = now.timeIntervalSinceReferenceDate

//let oneday = 86400
//
//let tomorrow = now + oneday

let timeInterval : TimeInterval = 86400

//print(tomorrow)

print(now)

// Calender

let calender = Calendar(identifier: .gregorian)

calender.locale
calender.timeZone

let calender2 = Calendar.current


calender2.locale
calender2.timeZone
calender2.identifier

// dateComponent

var dateComponent = DateComponents()

dateComponent.year = 2022
dateComponent.month = 2
dateComponent.day = 22

var date = Calendar.current.date(from: dateComponent)!


extension Date {
    
    init?(year : Int, month : Int, day : Int) {
        var dateComponent = DateComponents()
        dateComponent.year = year
        dateComponent.month = month
        dateComponent.day = day
        
        guard let date = Calendar.current.date(from: dateComponent) else {
            return nil
        }
        
        self = date
    }
    
}

let myDate = Date(year: 1893, month: 3, day: 5)!

let calendar = Calendar.current

let weekday = calendar.component(.weekday, from: myDate)
