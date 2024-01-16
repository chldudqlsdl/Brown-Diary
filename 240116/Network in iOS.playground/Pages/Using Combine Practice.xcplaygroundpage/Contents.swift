//: [Previous](@previous)

import Foundation
import Combine

enum NetworkError: Error {
    case invalidRequest
    case responseError(statusCode: Int)
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
    
    func fetchProfile() -> AnyPublisher<GithubProfile, Error> {
        
        let publisher = session
            .dataTaskPublisher(for: url)
            .tryMap { result in
                guard let httpResponse = result.response as? HTTPURLResponse, (200..<300).contains(httpResponse.statusCode) else {
                    let httpResponse = result.response as? HTTPURLResponse
                    let code = httpResponse?.statusCode ?? -1
                    throw NetworkError.responseError(statusCode: code)
                }
                return result.data
            }
            .decode(type: GithubProfile.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
        
        return publisher
    }
}

let networkService = NetworkService(configuration: URLSessionConfiguration.default)
let subsription = networkService
    .fetchProfile()
    .sink { completion in
        print(completion)
    } receiveValue: { profile in
        print(profile)
    }



//: [Next](@next)
