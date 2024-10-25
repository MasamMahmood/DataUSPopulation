//
//  Path.swift
//  DataUSPopulation
//
//  Created by Masam Mahmood on 25/10/2024.
//

import Foundation

// MARK: - Path
enum Path: String {
    case nation
    case state
    
    var path: String {
        switch self {
        case .nation: //nation
            return "/api/data"
        case .state: // State
            return "/api/data"
        }
    }
}
