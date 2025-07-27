import Foundation

/// Protocol that defines an API endpoint configuration
protocol Endpoint {
    /// The base URL for the API
    var baseURL: String { get }
    
    /// The path for this specific endpoint
    var path: String { get }
    
    /// The HTTP method to use
    var method: HTTPMethod { get }
    
    /// Headers to include in the request
    var headers: [String: String]? { get }
    
    /// Query parameters to include in the URL
    var queryParameters: [String: Any]? { get }
    
    /// Request body data
    var body: Data? { get }
    
    /// Request timeout interval in seconds
    var timeout: TimeInterval { get }
}

extension Endpoint {
    /// Default timeout of 30 seconds
    var timeout: TimeInterval { 30.0 }
    
    /// Default headers (can be overridden)
    var headers: [String: String]? {
        [
            "Content-Type": "application/json",
            "Accept": "application/json"
        ]
    }
    
    /// Default query parameters (empty)
    var queryParameters: [String: Any]? { nil }
    
    /// Default body (empty)
    var body: Data? { nil }
    
    /// Constructs the full URL for the endpoint
    var url: URL? {
        var components = URLComponents(string: baseURL + path)
        
        if let queryParams = queryParameters {
            components?.queryItems = queryParams.map { key, value in
                URLQueryItem(name: key, value: "\(value)")
            }
        }
        
        return components?.url
    }
    
    /// Creates a URLRequest from the endpoint configuration
    func asURLRequest() throws -> URLRequest {
        guard let url = url else {
            throw HTTPError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.timeoutInterval = timeout
        
        // Add headers
        headers?.forEach { key, value in
            request.setValue(value, forHTTPHeaderField: key)
        }
        
        // Add body
        request.httpBody = body
        
        return request
    }
} 