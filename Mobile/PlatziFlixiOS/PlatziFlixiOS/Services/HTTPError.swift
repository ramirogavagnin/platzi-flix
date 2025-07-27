import Foundation

/// HTTP-specific errors that can occur during network requests
enum HTTPError: Error, LocalizedError, Equatable {
    case invalidURL
    case noData
    case decodingError(String)
    case encodingError(String)
    case networkError(String)
    case serverError(Int, String)
    case clientError(Int, String)
    case unauthorized
    case forbidden
    case notFound
    case timeout
    case noInternetConnection
    case unknown(String)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL provided"
        case .noData:
            return "No data received from server"
        case .decodingError(let message):
            return "Failed to decode response: \(message)"
        case .encodingError(let message):
            return "Failed to encode request: \(message)"
        case .networkError(let message):
            return "Network error: \(message)"
        case .serverError(let code, let message):
            return "Server error (\(code)): \(message)"
        case .clientError(let code, let message):
            return "Client error (\(code)): \(message)"
        case .unauthorized:
            return "Unauthorized access"
        case .forbidden:
            return "Access forbidden"
        case .notFound:
            return "Resource not found"
        case .timeout:
            return "Request timeout"
        case .noInternetConnection:
            return "No internet connection available"
        case .unknown(let message):
            return "Unknown error: \(message)"
        }
    }
    
    var isRetryable: Bool {
        switch self {
        case .networkError, .timeout, .noInternetConnection, .serverError:
            return true
        default:
            return false
        }
    }
} 