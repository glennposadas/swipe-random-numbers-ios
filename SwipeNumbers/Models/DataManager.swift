//
//  DataManager.swift
//  SwipeLetters
//
//  Created by Glenn Posadas on 1/21/21.
//

import Foundation

struct DataManager {
    static var numbers: [String] = [
        "1", "2", "3", "4", "5", "6", "7", "8", "9", "10"
    ]
    
    static var data: [String] {
        get {
            if ENVManager.currentEnv == .development {
                return ["1", "2", "3", "4", "4"]
            }
            
            let useRandomizeLetters = AppDefaults.getObjectWithKey(.useRandomizeLetters, type: Bool.self) ?? false
            return useRandomizeLetters ? numbers.shuffled() : numbers
        }
    }
}
