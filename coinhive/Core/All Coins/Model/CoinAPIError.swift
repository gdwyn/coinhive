//
//  CoinAPIError.swift
//  coinhive
//
//  Created by Godwin IE on 27/09/2024.
//

import Foundation

enum CoinAPIError: Error {
    case invalidURL
    case invalidData
    case jsonParsingFailure
    case requestFailed(description: String)
    case invalidStatusCode(code: Int)
    case unknownError(error: Error)
    
    var customDescription: String {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .invalidData:
            return "Invalid data"
        case .jsonParsingFailure:
            return "Failed to parse JSON"
        case .requestFailed(let description):
            return "Request failed \(description )"
        case .invalidStatusCode(let code):
            return "\(code) There is a problem with the server"
        case .unknownError(let error):
            return "An unknown error occured: \(error.localizedDescription)"
        }
    }
}
