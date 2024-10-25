//
//  Header.swift
//  DataUSPopulation
//
//  Created by Masam Mahmood on 25/10/2024.
//

import Foundation

// MARK: - Header
enum Header {
    case defaultHeader
    
    var header: [String : String]? {
        switch self {
        case .defaultHeader:
            return nil
        }
    }
}
