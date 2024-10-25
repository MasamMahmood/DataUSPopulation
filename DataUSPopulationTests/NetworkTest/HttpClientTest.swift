//
//  HttpClientTest.swift
//  DataUSPopulationTests
//
//  Created by Masam Mahmood on 25/10/2024.
//

import Foundation
@testable import DataUSPopulation
import XCTest

class HttpClientTest: XCTestCase {
    var urlSession: URLSession!
    var endpoint: Endpoint!
    var service: HTTPClientProtocol!
    
    let mockString =
    """
    {
        "data": [
            {
                "ID Nation": "01000US",
                "Nation": "United States",
                "ID Year": 2022,
                "Year": "2022",
                "Population": 331097593,
                "Slug Nation": "united-states"
            }
        ]
    }
    """
    
    override func setUp() {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        
        urlSession = URLSession(configuration: config)
        endpoint = AllNationEndPoint()
        service = HttpClient(urlSession: urlSession)
    }
    
    override func tearDown() {
        urlSession = nil
        endpoint = nil
        super.tearDown()
    }
    
    func test_Get_Data_Success() async throws {
        var urlComponents = URLComponents()
        urlComponents.scheme = endpoint.scheme
        urlComponents.host = endpoint.host.url
        urlComponents.path = endpoint.path.path
        urlComponents.queryItems = endpoint.queryItems
        
        let response = HTTPURLResponse(url: urlComponents.url!,
                                       statusCode: 200,
                                       httpVersion: nil,
                                       headerFields: ["Content-Type": "application/json"])!
        
        let mockData: Data = Data(mockString.utf8)
        
        MockURLProtocol.requestHandler = { request in
            return (response, mockData)
        }
        
        let expectation = XCTestExpectation(description: "response")
        
        Task {
            let result = await service.sendRequest(endpoint: endpoint,
                                           responseModel: NationResponse.self)
            switch result {
            case .success(let success):
                XCTAssertEqual(success.data?.count, 1)
                expectation.fulfill()
            case .failure(let failure):
                XCTAssertThrowsError(failure)
            }
        }
        await fulfillment(of: [expectation], timeout: 2)
    }
    
    func test_Nation_BadResponse() {
        var urlComponents = URLComponents()
        urlComponents.scheme = endpoint.scheme
        urlComponents.host = endpoint.host.url
        urlComponents.path = endpoint.path.path
        urlComponents.queryItems = endpoint.queryItems
        
        let response = HTTPURLResponse(url: urlComponents.url!,
                                       statusCode: 400,
                                       httpVersion: nil,
                                       headerFields: ["Content-Type": "application/json"])!
        
        let mockData: Data = Data(mockString.utf8)
        
        MockURLProtocol.requestHandler = { request in
            return (response, mockData)
        }
        
        let expectation = XCTestExpectation(description: "response")
        
        Task {
            let result = await service.sendRequest(endpoint: endpoint,
                                           responseModel: NationResponse.self)
            switch result {
            case .success(_):
                XCTAssertThrowsError("Fatal Error")
            case .failure(let failure):
                XCTAssertEqual(RequestError.unexpectedStatusCode, failure)
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 2)
    }
    
    func test_Nation_EncodingError() {
        var urlComponents = URLComponents()
        urlComponents.scheme = endpoint.scheme
        urlComponents.host = endpoint.host.url
        urlComponents.path = endpoint.path.path
        urlComponents.queryItems = endpoint.queryItems
        
        let response = HTTPURLResponse(url: urlComponents.url!,
                                       statusCode: 200,
                                       httpVersion: nil,
                                       headerFields: ["Content-Type": "application/json"])!
        
        let mockData: Data = Data(mockString.utf8)
        
        MockURLProtocol.requestHandler = { request in
            return (response, mockData)
        }
        
        let expectation = XCTestExpectation(description: "response")
        
        Task {
            let result = await service.sendRequest(endpoint: endpoint,
                                           responseModel: [NationResponse].self)
            switch result {
            case .success(_):
                XCTAssertThrowsError("Fatal Error")
            case .failure(let failure):
                XCTAssertEqual(RequestError.decode, failure)
                expectation.fulfill()
            }
        }
    }
    
    func test_Nation_InvalidURL() {
        var urlComponents = URLComponents()
        urlComponents.scheme = endpoint.scheme
        urlComponents.host = "endpoint.host.url"
        urlComponents.path = " endpoint.path.path"
        urlComponents.queryItems = endpoint.queryItems
        
        let expectation = XCTestExpectation(description: "Invalid URL")
        
        if let url = urlComponents.url {
            let response = HTTPURLResponse(url: url,
                                           statusCode: 200,
                                           httpVersion: nil,
                                           headerFields: ["Content-Type": "application/json"])!
        } else {
            XCTAssertEqual(urlComponents.url, nil)
            expectation.fulfill()
        }
    }
}
