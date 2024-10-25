//
//  DataPopulationListService.swift
//  DataUSPopulation
//
//  Created by Masam Mahmood on 25/10/2024.
//

import Foundation

// MARK: - DataPoupulationServiceable
protocol DataListServiceable {
    func fetchAllNation() async -> Result<NationResponse, RequestError>
    func fetchAllState() async -> Result<StateResponse, RequestError>
}

// MARK: - DataPopulationService
struct DataPopulationListService: DataListServiceable {
    private let service: HTTPClientProtocol
    
    init(service: HTTPClientProtocol) {
        self.service = service
    }
 
    func fetchAllNation() async -> Result<NationResponse, RequestError> {
        return await service.sendRequest(endpoint: AllNationEndPoint(), responseModel: NationResponse.self)
    }
    
    func fetchAllState() async -> Result<StateResponse, RequestError> {
        return await service.sendRequest(endpoint: AllStateEndPoint(), responseModel: StateResponse.self)
    }
}
