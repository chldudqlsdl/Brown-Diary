//
//  FrameworkDetailViewModel.swift
//  AppleFramework
//
//  Created by Youngbin Choi on 1/22/24.
//

import Foundation
import Combine

final class FrameworkDetailViewModel {
    
    init(framework: AppleFramework) {
        self.framework = CurrentValueSubject(framework)
    }
    
    // Input
    let buttonTapped = PassthroughSubject<AppleFramework, Never>()
    func learnMoreTapped() {
        buttonTapped.send(framework.value)
    }

    
    // Output
    let framework : CurrentValueSubject<AppleFramework, Never>
    
}
