//
//  RequestError.swift
//  DataUSPopulation
//
//  Created by Masam Mahmood on 25/10/2024.
//

import Foundation

// MARK: - RequestError
public enum RequestError: Error, Equatable {
    case decode
    case invalidURL
    case noResponse
    case unauthorized(code:Int)
    case unexpectedStatusCode
    case unknown(description: String, code: Int?)
    
    public var customMessage: String {
        switch self {
        case .decode:
            return "Decoding Error"
        case .unauthorized:
            return "Session expired"
        case .noResponse:
            return "No Response"
        case .invalidURL:
            return "URL is invalid"
        default:
            return "Unknown error"
        }
    }
    
    public var errorCode: Int? {
        switch self {
        case .decode:
            return nil
        case .invalidURL:
            return nil
        case .noResponse:
            return nil
        case .unauthorized(let code):
            return code
        case .unexpectedStatusCode:
            return nil
        case .unknown(_, let code):
            return code
        }
    }
}
