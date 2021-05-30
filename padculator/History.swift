//
//  History.swift
//  padculator
//
//  Created by mac024 on 2021/05/28.
//

import Foundation

class History {
    var expression: String
    var result: Double
    
    init(expression: String, result: Double) {
        self.expression = expression
        self.result = result
    }
}
