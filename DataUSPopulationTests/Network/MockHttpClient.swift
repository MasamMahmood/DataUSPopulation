//
//  MockHttpClient.swift
//  DataUSPopulationTests
//
//  Created by Masam Mahmood on 25/10/2024.
//

import Foundation
@testable import DataUSPopulation

final class MockHttpClient: DataListServiceable {
    
    let filename: String
    private let service: Mockable
    
    init(filename: String, service: Mockable) {
        self.filename = filename
        self.service = service
    }
    
    func fetchAllNation() async -> Result<NationResponse, RequestError> {
        return await service.loadJson(filename: filename,
                              extensionType: .json,
                              responseModel: NationResponse.self)
    }
    
    func fetchAllState() async -> Result<StateResponse, RequestError> {
        return await service.loadJson(filename: filename,
                              extensionType: .json,
                              responseModel: StateResponse.self)
    }
}
