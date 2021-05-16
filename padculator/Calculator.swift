//
//  Calculator.swift
//  padculator
//
//  Created by mac024 on 2021/05/16.
//

import Foundation

func calculate(equation: String) -> Double? {
    let expression = NSExpression(format: equation)
    let result = expression.expressionValue(with: nil, context: nil) as? Double
    return result
}
