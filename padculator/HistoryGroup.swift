//
//  HistoryGroup.swift
//  padculator
//
//  Created by mac024 on 2021/05/28.
//

import Foundation

class HistoryGroup {
    var histories = [History]()
    
    func addHistory(history: History) {
        histories.insert(history, at: 0)
    }
    
    func removeHistory(index: Int) {
        histories.remove(at: index)
    }
}
