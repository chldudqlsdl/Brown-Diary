//
//  SearchViewModel.swift
//  GithubUserSearch
//
//  Created by Youngbin Choi on 1/25/24.
//

import Foundation
import Combine

final class SearchViewModel {
    
    //Combine
    var subscription = Set<AnyCancellable>()
    let users = CurrentValueSubject<[SearchResult], Never>([])
    
    func Search(_ keyword : String) {
        
        let networkservice = NetworkService(configuration: .default)
        
        let resource: Resource<SearchUserResponse> = Resource(
            base: "https://api.github.com/",
            path: "search/users",
            params: ["q": keyword],
            header: ["Content-Type": "application/json"]
        )
        
        networkservice
            .load(resource)
            .map {$0.items}
            .
            
    }
}
