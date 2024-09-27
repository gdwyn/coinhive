//
//  CoinAPIError.swift
//  coinhive
//
//  Created by Godwin IE on 27/09/2024.
//

import Foundation

enum CoinAPIError: Error {
    case invalidData
    case jsonParsingFailure
    case requestFailed(description: String)
    case invalidStatusCode(code: Int)
    case unknownError(error: Error)
    
    var customDescription: String {
        switch self {
        case .invalidData:
            return "Invalid data"
        case .jsonParsingFailure:
            return "Failed to parse JSON"
        case .requestFailed(let description):
            return "Request failed \(description )"
        case .invalidStatusCode(let code):
            return "Invalid status code: \(code)"
        case .unknownError(let error):
            return "An unknown error occured: \(error.localizedDescription)"
        }
    }
}
