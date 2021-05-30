//
//  Calculator.swift
//  padculator
//
//  Created by mac024 on 2021/05/16.
//

import Foundation

func calculate(expression: String) -> Double? {
    let x = NSExpression(format: replaceMathSymbols(expression: expression))
    let result = x.expressionValue(with: nil, context: nil) as? Double
    return result
}

func replaceMathSymbols(expression: String) -> String {
    return expression.replacingOccurrences(of: "^", with: "**")
}

func doubleToString(_ d: Double) -> String {
    return d.remainder(dividingBy: 1.0) == 0 ? String(Int(d)) : String(d)
}
