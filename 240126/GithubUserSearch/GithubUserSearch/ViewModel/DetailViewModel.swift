//
//  DetailViewModel.swift
//  GithubUserSearch
//
//  Created by Youngbin Choi on 1/26/24.
//

import Foundation
import Combine

final class DetailViewModel {
    
    var user = PassthroughSubject<SearchResult, Never>()
    
}
