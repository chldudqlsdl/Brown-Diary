import UIKit

// 네트워크 통신의 기초
struct MovieData: Codable {
    let boxOfficeResult: BoxOfficeResult
}

struct BoxOfficeResult: Codable {
    let boxofficeType, showRange: String
    let dailyBoxOfficeList: [DailyBoxOfficeList]
}

struct DailyBoxOfficeList: Codable {
    let rank: String
    let movieNm: String
    let audiCnt: String
    let audiAcc: String
    let openDt: String
}

let movieURLString = "http://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=49adeead267923e9d7b5b82e78ed8616&targetDt=20240218"

let movieURL = URL(string: movieURLString)!

let session = URLSession.shared

let dataTask = session.dataTask(with: movieURL) { data, response, error in
    
    if error != nil {
        print("에러발생")
        return
    }
    
    guard let data = data else { return }
    
    let result = parseJSON(data)!
    
    let movieNameList = result.map { element in
        element.movieNm
    }
    
    print(movieNameList)
    
}

func parseJSON(_ data : Data) -> [DailyBoxOfficeList]? {
    
    let decoder = JSONDecoder()
    do {
        let movieData = try decoder.decode(MovieData.self, from: data)
        return movieData.boxOfficeResult.dailyBoxOfficeList
    } catch {
        return nil
    }
}

dataTask.resume()
