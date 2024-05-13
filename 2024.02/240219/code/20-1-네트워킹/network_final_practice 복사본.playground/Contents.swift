import Foundation

// 뷰 컨트롤러에서 원하는 날짜의 박스오피스 10위까지의 영화 정보를 얻고 싶다

var result = [Movie]()

let movieDataManager = MovieDataManager()

movieDataManager.fetchMovie(date: "20240218") { movies in
    guard let movies = movies else {
        print("영화 데이터를 가져오는데 실패했습니다")
        return
    }
    result = movies
    dump(result)
    print("전체영화갯수 : \(Movie.movieId)")
}

// Movie Model

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

struct Movie {
    static var movieId : Int = 0
    let rank : String
    let movieName : String
    let todayAudience : Int
    let totalAudience : Int
    let opendate : String
    
    init(rank: String, movieNm: String, audiCnt: String, audiAcc: String, openDt: String) {
        
        self.rank = rank
        self.movieName = movieNm
        self.todayAudience = Int(audiCnt)!
        self.totalAudience = Int(audiAcc)!
        self.opendate = openDt
        Movie.movieId += 1
    }
}

// MovieDataManager

struct MovieDataManager {
    
    let myKey = "49adeead267923e9d7b5b82e78ed8616"
    
    let movieURL = "http://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?"
    
    func fetchMovie(date : String , completion: @escaping ([Movie]?) -> Void) {
        
        let urlString = movieURL + "key=\(myKey)&targetDt=\(date)"
        
        print(urlString)
        
        performRequest(url: URL(string: urlString)! ) { movies in
            completion(movies)
        }
    }
    
    func performRequest(url : URL , completion: @escaping ([Movie]?) -> Void) {
        
        let urlSession = URLSession.shared
        
        let dataTask = urlSession.dataTask(with: url) { data, response, error in
            if error != nil {
                completion(nil)
                return
            }
            
            guard let data = data else {
                completion(nil)
                return
            }
                        
            guard let movies = parseJSON(data) else {
                completion(nil)
                return
            }
            completion(movies)
            
        }
        
        dataTask.resume()
        
    }
    
    func parseJSON(_ data : Data) -> [Movie]? {
        
        let decoder = JSONDecoder()
        
        do {
            let moviesDataArray = try decoder.decode(MovieData.self, from: data)
            let moviesArray = moviesDataArray.boxOfficeResult.dailyBoxOfficeList
            
            let result = moviesArray.map {
                Movie(rank: $0.rank, movieNm: $0.movieNm, audiCnt: $0.audiCnt, audiAcc: $0.audiAcc, openDt: $0.openDt)
            }
            
            return result
            
        } catch {
            print("파싱실패")
            return nil
        }
    }
    
}


