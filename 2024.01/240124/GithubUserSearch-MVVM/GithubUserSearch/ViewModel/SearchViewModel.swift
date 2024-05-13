//
//  SearchViewModel.swift
//  GithubUserSearch
//
//  Created by Youngbin Choi on 1/24/24.
//

import Foundation
import Combine

class SearchViewModel {
    
    // Combine
    let network = NetworkService(configuration: .default)
    var subscriptions = Set<AnyCancellable>()
    
    
    // Data -> Output
//    @Published private(set) var users = [SearchResult]()
    var users = CurrentValueSubject<[SearchResult], Never>([])
    
    // UserAction -> Input
    func search(_ keyword : String) {
        let resource: Resource<SearchUserResponse> = Resource(
            base: "https://api.github.com/",
            path: "search/users",
            params: ["q": keyword],
            header: ["Content-Type": "application/json"]
        )
        
        network.load(resource)
            .print()
            .map { $0.items }
            .replaceError(with: [])
            .receive(on: RunLoop.main)
//            .assign(to: \.users.value, on: self)
            .sink(receiveValue: { response in
                self.users.send(response)
            })
            .store(in: &subscriptions)
        
    }
}
