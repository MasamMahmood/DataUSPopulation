//
//  AllNationEndPoint.swift
//  DataUSPopulation
//
//  Created by Masam Mahmood on 25/10/2024.
//

import Foundation

// MARK: - AllNationEndpoint
struct AllNationEndPoint: Endpoint {
    
     private enum Constant {
         static let measures: String = "Population"
    }
    
    var path: Path {
        return .nation
    }
    
    var queryItems: [URLQueryItem]? {
        return [URLQueryItem(name: "drilldowns", value: DrillDowns.Nation.type),
                URLQueryItem(name: "measures", value: Constant.measures)
        ]
    }
}
