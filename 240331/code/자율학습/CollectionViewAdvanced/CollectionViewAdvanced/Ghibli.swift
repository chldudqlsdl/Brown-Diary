//
//  Ghibli.swift
//  CollectionViewAdvanced
//
//  Created by Youngbin Choi on 3/30/24.
//

import Foundation

struct Ghibli {
    static let main = [Movie(title: "천공의성 라퓨타"), Movie(title: "센과 치히로의 행방불명"), Movie(title: "이웃집 토토로"), Movie(title: "모노노케 히메"), Movie(title: "하울의 움직이는 성"), Movie(title: "바람이 분다"), Movie(title: "바다가 들린다"), Movie(title: "마녀배달부 키키"), Movie(title: "붉은돼지")]
    static let sub = Array([Movie(title: "천공의성 라퓨타"), Movie(title: "센과 치히로의 행방불명"), Movie(title: "이웃집 토토로"), Movie(title: "모노노케 히메"), Movie(title: "하울의 움직이는 성"), Movie(title: "바람이 분다"), Movie(title: "바다가 들린다"), Movie(title: "마녀배달부 키키"), Movie(title: "붉은돼지")].reversed())
}

struct Movie : Hashable {
    var uuid = UUID()
    var title : String
}

enum Section : Int, CaseIterable {
    case main
    case sub
    
    var sectionName : String {
        switch self {
        case .main: return "평점순"
        case .sub: return "관객순"
        }
    }
    
    var sectionColumn : Int {
        switch self {
        case .main : return 3
        case .sub : return 2
        }
    }
    
    var groupHeight : CGFloat {
        switch self {
        case .main : return 0.27
        case .sub : return 0.35
        }
    }
}

