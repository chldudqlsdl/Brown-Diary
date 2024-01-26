//
//  SearchViewModel.swift
//  GithubUserSearch
//
//  Created by Youngbin Choi on 1/26/24.
//

import Foundation
import Combine

final class SearchViewModel {
    
    //Combine
    var subscriptions = Set<AnyCancellable>()
    
    // Output
    var users = CurrentValueSubject<[SearchResult], Never>([])
    
    // Input
    func search(_ keyword : String) {
        
        let base = "https://api.github.com/"
        let path = "search/users"
        let params: [String: String] = ["q": keyword]
        let header: [String: String] = ["Content-Type": "application/json"]
        
        var urlComponents = URLComponents(string: base + path)!
        let queryItems = params.map { (key: String, value: String) in
            URLQueryItem(name: key, value: value)
        }
        urlComponents.queryItems = queryItems
        
        var urlRequest = URLRequest(url: urlComponents.url!)
        
        header.forEach { (key: String, value: String) in
            urlRequest.addValue(value, forHTTPHeaderField: key)
        }
        
        let subscription = URLSession.shared
            .dataTaskPublisher(for: urlRequest)
            .receive(on: RunLoop.main)
            .tryMap { result in
                guard let httpResponse = result.response as? HTTPURLResponse, (200..<300).contains(httpResponse.statusCode) else {
                    let httpResponse = result.response as? HTTPURLResponse
                    throw NetworkError.responseError(statusCode: httpResponse?.statusCode ?? -1)
                }
                return result.data
            }
            .decode(type: SearchUserResponse.self, decoder: JSONDecoder())
            .map{$0.items}
            .sink { completion in
                print("completion message : \(completion)")
            } receiveValue: { [unowned self] result in
                self.users.send(result)
            }
            .store(in: &subscriptions)
    }
}
