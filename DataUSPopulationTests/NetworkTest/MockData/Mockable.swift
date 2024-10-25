//
//  Mockable.swift
//  DataUSPopulationTests
//
//  Created by Masam Mahmood on 25/10/2024.
//

import Foundation
@testable import DataUSPopulation

enum FileExtensionType: String {
    case json = ".json"
}

protocol Mockable: AnyObject {
    var bundle: Bundle { get }
    func loadJson<T: Decodable>(filename: String,
                                extensionType: FileExtensionType,
                                responseModel: T.Type) async -> Result<T, RequestError>  where T : Decodable
}

class Mock: Mockable {
    var bundle: Bundle {
        Bundle(for: type(of: self))
    }
    
    func loadJson<T: Decodable>(filename: String,
                                extensionType: FileExtensionType,
                                responseModel: T.Type) async -> Result<T, RequestError> {
        guard let path = bundle.url(forResource: filename,
                                    withExtension: extensionType.rawValue) else {
            return .failure(.invalidURL)
        }
        
        do {
            let data = try Data(contentsOf: path)
            let decodedObject = try JSONDecoder().decode(T.self, from: data)
            return .success(decodedObject)
        } catch {
            return .failure(.unknown(description: "text", code: nil))
        }
    }
}
