//: [Previous](@previous)

import Foundation

enum NetworkError: Error {
  case invalidRequest
  case transportError(Error)
  case responseError(statusCode: Int)
  case noData
  case decodingError(Error)
}

struct GithubProfile: Codable {
    let login: String
    let avatarUrl: String
    let htmlUrl: String
    let followers: Int
    let following: Int
    
    enum CodingKeys: String, CodingKey {
        case login
        case avatarUrl = "avatar_url"
        case htmlUrl = "html_url"
        case followers
        case following
    }
}

final class NetworkService {
    
    let session : URLSession
    
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    func fetchProfile(name : String, completion : @escaping (Result<GithubProfile, Error>) -> Void) {
        let url = URL(string: "https://api.github.com/users/\(name)")!
        
        let task = session.dataTask(with: url) { data, response, error in
            
            if let error = error {
                completion(.failure(NetworkError.transportError(error)))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200..<300).contains(httpResponse.statusCode) else {
                let httpResponse = response as? HTTPURLResponse
                completion(.failure(NetworkError.responseError(statusCode: httpResponse?.statusCode ?? -1)))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let profile = try decoder.decode(GithubProfile.self, from: data)
                completion(.success(profile))
            } catch let error {
                completion(.failure(NetworkError.decodingError(error)))
            }
        }
        task.resume()
    }
}

let networkService = NetworkService(configuration: .default)
networkService.fetchProfile(name: "chldudqlsdl") { result in
    switch result {
    case .failure(let error) :
        print("Error: \(error as NSError)")
    case .success(let profile) :
        print("Profile: \(profile)")
    }
}







//: [Next](@next)
