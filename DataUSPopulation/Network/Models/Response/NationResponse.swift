//
//  NationResponse.swift
//  DataUSPopulation
//
//  Created by Masam Mahmood on 25/10/2024.
//

import Foundation

// MARK: - NationResponse
struct NationResponse: Codable {
    let data: [NationData]?
}

// MARK: - NationData
struct NationData: Codable, Identifiable {
    let id = UUID()
    let idNation: String
    let nation: String
    let idYear: Int
    let year: String
    let population: Int
    let slugNation: String
    
    enum CodingKeys: String, CodingKey {
        case idNation = "ID Nation"
        case nation = "Nation"
        case idYear = "ID Year"
        case year = "Year"
        case population = "Population"
        case slugNation = "Slug Nation"
    }
}
