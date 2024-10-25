//
//  AllStateEndPoint.swift
//  DataUSPopulation
//
//  Created by Masam Mahmood on 25/10/2024.
//

import Foundation

// MARK: - AllStateEndpoint
struct AllStateEndPoint: Endpoint {
    
     private enum Constant {
         static let measures: String = "Population"
         static let year: String = "latest"
    }
    
    var path: Path {
        return .state
    }
    
    var queryItems: [URLQueryItem]? {
        return [URLQueryItem(name: "drilldowns", value: DrillDowns.State.type),
                URLQueryItem(name: "measures", value: Constant.measures),
                URLQueryItem(name: "year", value: Constant.year)
        ]
    }
}
