//
//  DrillDowns.swift
//  DataUSPopulation
//
//  Created by Masam Mahmood on 25/10/2024.
//

import Foundation

// MARK: - DrillDowns
 enum DrillDowns {
    case Nation
    case State
    
    var type: String {
        switch self {
        case .Nation:
            return "Nation"
        case .State:
            return "State"
        }
    }
}
