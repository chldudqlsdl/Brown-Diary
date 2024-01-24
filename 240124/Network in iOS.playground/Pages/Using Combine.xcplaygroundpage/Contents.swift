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

final class Networkservice {
    let session : URLSession
    
    init(configuration : URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    let url = URL(string: "https://api.github.com/users/chldudqlsdl")!
    
    func fetchProfile() -> AnyPublisher<GithubProfile, Error> {
        
        session.dataTaskPublisher(for: url)
            .tryMap { result in
                guard let httpResponse = result.response as? HTTPURLResponse, (200..<300).contains(httpResponse.statusCode) else {
                    let httpResponse = result.response as? HTTPURLResponse
                    throw NetworkError.responseError(statusCode: httpResponse?.statusCode ?? -1)
                }
                return result.data
            }
            .decode(type: GithubProfile.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}

let networkservice = Networkservice(configuration: .default)
let subscription = networkservice
    .fetchProfile()
    .receive(on: RunLoop.main)
    .sink { error in
        print("completion message : \(error)")
    } receiveValue: { profile in
        print(profile)
    }







//: [Next](@next)



