import Foundation

/// Builder pattern implementation for creating endpoints easily
struct EndpointBuilder {
    private var baseURL: String = NetworkConfiguration.current.baseURL
    private var path: String = ""
    private var method: HTTPMethod = .GET
    private var headers: [String: String]? = nil
    private var queryParameters: [String: Any]? = nil
    private var bodyData: Data? = nil
    private var timeout: TimeInterval = 30.0
    
    init() {}
    
    // MARK: - Builder Methods
    
    func baseURL(_ url: String) -> EndpointBuilder {
        var builder = self
        builder.baseURL = url
        return builder
    }
    
    func path(_ path: String) -> EndpointBuilder {
        var builder = self
        builder.path = path
        return builder
    }
    
    func method(_ method: HTTPMethod) -> EndpointBuilder {
        var builder = self
        builder.method = method
        return builder
    }
    
    func headers(_ headers: [String: String]) -> EndpointBuilder {
        var builder = self
        builder.headers = headers
        return builder
    }
    
    func addHeader(key: String, value: String) -> EndpointBuilder {
        var builder = self
        if builder.headers == nil {
            builder.headers = [:]
        }
        builder.headers?[key] = value
        return builder
    }
    
    func queryParameters(_ parameters: [String: Any]) -> EndpointBuilder {
        var builder = self
        builder.queryParameters = parameters
        return builder
    }
    
    func addQueryParameter(key: String, value: Any) -> EndpointBuilder {
        var builder = self
        if builder.queryParameters == nil {
            builder.queryParameters = [:]
        }
        builder.queryParameters?[key] = value
        return builder
    }
    
    func body<T: Codable>(_ object: T) throws -> EndpointBuilder {
        var builder = self
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        builder.bodyData = try encoder.encode(object)
        return builder
    }
    
    func body(_ data: Data) -> EndpointBuilder {
        var builder = self
        builder.bodyData = data
        return builder
    }
    
    func timeout(_ timeout: TimeInterval) -> EndpointBuilder {
        var builder = self
        builder.timeout = timeout
        return builder
    }
    
    // MARK: - Build Method
    
    func build() -> BasicEndpoint {
        return BasicEndpoint(
            baseURL: baseURL,
            path: path,
            method: method,
            headers: headers,
            queryParameters: queryParameters,
            body: bodyData,
            timeout: timeout
        )
    }
}

// MARK: - Basic Endpoint Implementation

struct BasicEndpoint: Endpoint {
    let baseURL: String
    let path: String
    let method: HTTPMethod
    let headers: [String: String]?
    let queryParameters: [String: Any]?
    let body: Data?
    let timeout: TimeInterval
}

// MARK: - Convenience Extensions

extension EndpointBuilder {
    // Common HTTP methods
    static func get(_ path: String) -> EndpointBuilder {
        return EndpointBuilder().path(path).method(.GET)
    }
    
    static func post(_ path: String) -> EndpointBuilder {
        return EndpointBuilder().path(path).method(.POST)
    }
    
    static func put(_ path: String) -> EndpointBuilder {
        return EndpointBuilder().path(path).method(.PUT)
    }
    
    static func delete(_ path: String) -> EndpointBuilder {
        return EndpointBuilder().path(path).method(.DELETE)
    }
    
    static func patch(_ path: String) -> EndpointBuilder {
        return EndpointBuilder().path(path).method(.PATCH)
    }
} 