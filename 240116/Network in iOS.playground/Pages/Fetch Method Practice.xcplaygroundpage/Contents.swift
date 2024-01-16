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
    
    init(configuration : URLSessionConfiguration) {
        session = URLSession(configuration: configuration)
    }
    
    let url = URL(string:  "https://api.github.com/users/chldudqlsdl")!
    
    func fetchProfile(username: String, completion: @escaping (Result<GithubProfile, Error>) -> Void) {
        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
            }
            
            if let httpResponse = response as? HTTPURLResponse, !(200..<300).contains(httpResponse.statusCode) {
                completion(.failure(NetworkError.responseError(statusCode: httpResponse.statusCode)))
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }
            do {
                let decoder = JSONDecoder()
                let profile = try decoder.decode(GithubProfile.self, from: data)
                completion(.success(profile))
            } catch {
                completion(.failure(NetworkError.decodingError(error)))
            }
            
        }
        task.resume()
    }
}

let networkService = NetworkService(configuration: URLSessionConfiguration.default)
networkService.fetchProfile(username: "") { result in
    switch result {
    case .success(let profile) :
        print(profile)
    case .failure(let error):
        print(error)
    }
}

//: [Next](@next)
