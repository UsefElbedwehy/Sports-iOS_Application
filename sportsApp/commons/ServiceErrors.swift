//
//  ServiceErrors.swift
//  sportsApp
//
//  Created by Usef on 15/05/2025.
//

import Foundation

enum ServiceErrors: Error {
    case noData
    case urlFailed
    case decodingFailed(String)
    case urlSessionFailed
    case invalidResponse
    case customError(String)
    
    var msg: String {
        switch self {
        case .noData:
            return "No data available"
        case .urlFailed:
            return "URL failed"
        case .decodingFailed(let msg):
            return "Decoding failed: \(msg)"
        case .urlSessionFailed:
            return "URL Session failed"
        case .invalidResponse:
            return "Invalid response"
        case .customError(let msg):
            return msg
        }
    }
}
