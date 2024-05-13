//
//  NetworkingManager.swift
//  MusicApp
//
//  Created by Youngbin Choi on 4/4/24.
//

import Foundation




func getMethod(completion: @escaping ([Music]?) -> Void) {

    // URL구조체 만들기
    guard let url = URL(string: "https://itunes.apple.com/search?media=music&term=jazz") else {
        print("Error: cannot create URL")
        completion(nil)
        return
    }
    
    // URL요청 생성
    var request = URLRequest(url: url)
    request.httpMethod = "GET"

    
    // 요청을 가지고 작업세션시작
    
    URLSession.shared.dataTask(with: request) { data, response, error in
        // 에러가 없어야 넘어감
        guard error == nil else {
            print("Error: error calling GET")
            print(error!)
            completion(nil)
            return
        }
        // 옵셔널 바인딩
        guard let safeData = data else {
            print("Error: Did not receive data")
            completion(nil)
            return
        }
        // HTTP 200번대 정상코드인 경우만 다음 코드로 넘어감
        guard let response = response as? HTTPURLResponse, (200 ..< 299) ~= response.statusCode else {
            print("Error: HTTP request failed")
            completion(nil)
            return
        }
        do {
            let decoder = JSONDecoder()
            let musicData = try decoder.decode(MusicData.self, from: safeData)
            completion(musicData.results)
            return
        } catch {
            
        }
    }.resume()     // 시작


}



getMethod { musicArray in
    guard let array = musicArray else { return }
    dump(array)
}
