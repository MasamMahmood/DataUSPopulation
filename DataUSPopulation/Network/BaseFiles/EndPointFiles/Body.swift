//
//  Body.swift
//  DataUSPopulation
//
//  Created by Masam Mahmood on 25/10/2024.
//

import Foundation

// MARK: - Path
enum Body {
    case nilBody
    
    var body: [String: Any]? {
        switch self {
        case .nilBody:
            return nil
        }
    }
}
