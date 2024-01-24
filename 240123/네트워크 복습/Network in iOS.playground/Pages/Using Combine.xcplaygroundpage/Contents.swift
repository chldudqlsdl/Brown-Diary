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

//var subscriptions = Set<AnyCancellable>()

final class NetworkService {
    
    let session : URLSession
    
    init(configuration: URLSessionConfiguration) {
        session = URLSession(configuration: configuration)
    }
    
    func fetchProfile(name : String) -> AnyPublisher<GithubProfile, Error> {
        
        let url = URL(string: "https://api.github.com/users/\(name)")!
        
        return session
            .dataTaskPublisher(for: url)
            .tryMap { result in
                guard let httpResponse = result.response as? HTTPURLResponse, (200..<300).contains(httpResponse.statusCode)
                else {
                    let response = result.response as? HTTPURLResponse
                    let statuscode = response?.statusCode ?? -1
                    throw NetworkError.responseError(statusCode: statuscode)
                }
                return result.data
            }
            .decode(type: GithubProfile.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
        
    }
}

let networkservice = NetworkService(configuration: .default)
let hi = networkservice
    .fetchProfile(name: "cafielo")
    .print()
    .receive(on: RunLoop.main)
    .sink { error in
        print("error: \(error)")
    } receiveValue: { profile in
        print("profile: \(profile)")
    }
// let subscription = networkservice 하면 되는데, 바로 networkservice 쓰면 안 됨
// .store 와 관련된 메모리 문제인듯

//: [Next](@next)



