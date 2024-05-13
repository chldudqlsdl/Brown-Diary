//
//  BMICalculationManager.swift
//  BMI
//
//  Created by Youngbin Choi on 3/14/24.
//

import Foundation
import UIKit

struct BMICalculationManager {
    
    // BMI계산 결과값 보관위한 변수
    private var bmi: BMI?
    
    // BMI 계산 결과값 리턴하는 함수
    mutating func getBMI(height: String, weight: String) -> BMI {
        calculateBMI(height: height, weight: weight)
        return bmi ?? BMI(value: 0.0, bgColor: .white, advice: "문제발생")
    }
    
    // BMI계산 메서드
    mutating func calculateBMI(height: String, weight: String) {
        guard let h = Double(height), let w = Double(weight) else {
            bmi = BMI(value: 0.0, bgColor: .white, advice: "문제발생")
            return
        }
        var bmiNum = w / (h * h) * 10000
        bmiNum = round(bmiNum * 10) / 10
        
        // 색깔, 문자열 얻는 메서드
        switch bmiNum {
        case ..<18.6:
            let color = UIColor(displayP3Red: 22/255, green: 231/255, blue: 207/255, alpha: 1)
            bmi = BMI(value: bmiNum, bgColor: color, advice: "저체중")
        case 18.6..<23.0:
            let color = UIColor(displayP3Red: 212/255, green: 251/255, blue: 121/255, alpha: 1)
            bmi = BMI(value: bmiNum, bgColor: color, advice: "표준")
        case 23.0..<25.0:
            let color = UIColor(displayP3Red: 218/255, green: 127/255, blue: 163/255, alpha: 1)
            bmi = BMI(value: bmiNum, bgColor: color, advice: "과체중")
        case 25.0..<30.0:
            let color = UIColor(displayP3Red: 255/255, green: 150/255, blue: 141/255, alpha: 1)
            bmi = BMI(value: bmiNum, bgColor: color, advice: "중도비만")
        case 30.0...:
            let color = UIColor(displayP3Red: 255/255, green: 100/255, blue: 78/255, alpha: 1)
            bmi = BMI(value: bmiNum, bgColor: color, advice: "고도비만")
        default:
            let color = UIColor.black
            bmi = BMI(value: bmiNum, bgColor: color, advice: "")
        }
    }
}
