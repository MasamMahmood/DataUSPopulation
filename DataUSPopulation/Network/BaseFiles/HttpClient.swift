//
//  HttpClient.swift
//  DataUSPopulation
//
//  Created by Masam Mahmood on 25/10/2024.
//

import Foundation
import SwiftUI

protocol HTTPClientProtocol {
    func sendRequest<T: Decodable>(endpoint: Endpoint, responseModel: T.Type) async -> Result<T, RequestError>
}

class HttpClient: HTTPClientProtocol {
    
    private var urlSession: URLSession?
    
    init(urlSession: URLSession? = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    func sendRequest<T: Decodable>(
        endpoint: Endpoint,
        responseModel: T.Type
    ) async -> Result<T, RequestError> {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = endpoint.scheme
        urlComponents.host = endpoint.host.url
        urlComponents.path = endpoint.path.path
        urlComponents.queryItems = endpoint.queryItems
        
        debugPrint("QueryItems >>>>>> \(String(describing: endpoint.queryItems))")
        debugPrint("URL >>>>>> \(String(describing: urlComponents.url))")
        
        guard let url = urlComponents.url else {
            return .failure(.invalidURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.allHTTPHeaderFields = endpoint.header.header
        
        debugPrint("Method >>>>>> \(String(describing: endpoint.method))")
        debugPrint("Header >>>>>> \(String(describing: endpoint.header.header))")
        
        if let body = endpoint.body.body {
            request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
        }
        
        debugPrint("Body >>>>>> \(String(describing: endpoint.body))")
        
        do {
            var dataAndResponse: (Data, URLResponse)?
            
            dataAndResponse = try await urlSession?.data(for: request)
            
            guard let response = dataAndResponse?.1 as? HTTPURLResponse else {
                return .failure(.noResponse)
            }
            
            guard let data = dataAndResponse?.0 else {
                return .failure(.unknown(description: response.description, code:  response.statusCode))
            }
            guard let decodedResponse = try? JSONDecoder().decode(responseModel, from: data) else {
                return .failure(.decode)
            }
            
            switch response.statusCode {
            case 200...299:
                debugPrint("Response >>>>>> \(String(describing: decodedResponse))")
                return .success(decodedResponse)
            case 401:
                return .failure(.unauthorized(code:response.statusCode))
            default:
                debugPrint("Error >>>>>> \(String(describing: decodedResponse))")
                return .failure(.unexpectedStatusCode)
            }
        } catch {
            return .failure(.unknown(description: "Unknown error", code: nil))
        }
    }
}
