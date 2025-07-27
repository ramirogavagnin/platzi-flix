import Foundation

/// Protocol that defines the HTTP service interface
protocol HTTPService {
    /// Performs a generic HTTP request
    /// - Parameter endpoint: The endpoint configuration
    /// - Returns: The decoded response data
    func request<T: Codable>(endpoint: Endpoint) async throws -> T
    
    /// Performs a HTTP request without expecting a response body
    /// - Parameter endpoint: The endpoint configuration
    func request(endpoint: Endpoint) async throws
    
    /// Downloads data from a URL
    /// - Parameter url: The URL to download from
    /// - Returns: The downloaded data
    func downloadData(from url: URL) async throws -> Data
} 