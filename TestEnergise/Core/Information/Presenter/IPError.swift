//
//  IPError.swift
//  TestEnergise
//
//  Created by Andrii Kyrychenko on 22/07/2025.
//

import Foundation

enum IPError: Error, LocalizedError {
    
    case invalidURL
    case invalidResponse
    case noData
    case apiError(String)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return NSLocalizedString("invalidURL_error", comment: "")
        case .invalidResponse:
            return NSLocalizedString("invalid_response_error", comment: "")
        case .noData:
            return NSLocalizedString("no_data_error", comment: "")
        case .apiError(let string):
            return "\(NSLocalizedString("api_error", comment: "")) \(string)"
        }
    }
}
