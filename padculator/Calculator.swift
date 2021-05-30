//
//  Calculator.swift
//  padculator
//
//  Created by mac024 on 2021/05/16.
//

import Foundation

func calculate(equation: String) -> Double? {
    let expression = NSExpression(format: replaceMathSymbols(equation: equation))
    let result = expression.expressionValue(with: nil, context: nil) as? Double
    return result
}

func replaceMathSymbols(equation: String) -> String {
    return equation.replacingOccurrences(of: "^", with: "**")
}

func doubleToString(_ d: Double) -> String {
    return d.remainder(dividingBy: 1.0) == 0 ? String(Int(d)) : String(d)
}
