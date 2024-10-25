//
//  DataPopulationList.swift
//  DataUSPopulation
//
//  Created by Masam Mahmood on 25/10/2024.
//

import Foundation

// MARK: - DataPopulationList
enum DataPopulationList: ViewStateProtocol {
    case ready
    case loading
    case finished
    case error
    case empty
}
