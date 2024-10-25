//
//  StateResponse.swift
//  DataUSPopulation
//
//  Created by Masam Mahmood on 25/10/2024.
//

import Foundation

// MARK: - StateResponse
struct StateResponse: Codable {
    let data: [StateData]?
}

// MARK: - StateData
struct StateData: Codable, Identifiable {
    let id = UUID()
    let idState: String
    let state: String
    let idYear: Int
    let year: String
    let population: Int
    let slugState: String
    
    enum CodingKeys: String, CodingKey {
        case idState = "ID State"
        case state = "State"
        case idYear = "ID Year"
        case year = "Year"
        case population = "Population"
        case slugState = "Slug State"
    }
}
