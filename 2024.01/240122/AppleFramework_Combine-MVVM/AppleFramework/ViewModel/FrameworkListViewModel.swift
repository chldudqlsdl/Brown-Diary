//
//  FrameworkListViewModel.swift
//  AppleFramework
//
//  Created by Youngbin Choi on 1/22/24.
//

import Foundation
import Combine

final class FrameworkListViewModel {
    
    init(items: [AppleFramework], selectedItem: AppleFramework? = nil) {
        self.items = CurrentValueSubject(items)
        self.selectedItem = CurrentValueSubject(selectedItem)
    }
    
    // Output
    let items : CurrentValueSubject<[AppleFramework], Never>
    let selectedItem : CurrentValueSubject<AppleFramework?, Never>
    
    // Input
    func didSelect(at indexPath : IndexPath) {
        let framework = items.value[indexPath.item]
        selectedItem.send(framework)
    }
}
