import Foundation

/// Configuration for network settings
struct NetworkConfiguration {
    let baseURL: String
    let apiKey: String?
    let timeout: TimeInterval
    let enableLogging: Bool
    
    init(
        baseURL: String,
        apiKey: String? = nil,
        timeout: TimeInterval = 30.0,
        enableLogging: Bool = false
    ) {
        self.baseURL = baseURL
        self.apiKey = apiKey
        self.timeout = timeout
        self.enableLogging = enableLogging
    }
    
    /// Default configuration for development (local API server)
    static let development = NetworkConfiguration(
        baseURL: "http://localhost:8000",
        enableLogging: true
    )
    
    /// Default configuration for production
    static let production = NetworkConfiguration(
        baseURL: "https://api.platziflix.com",
        enableLogging: false
    )
    
    /// Current configuration based on build configuration
    static var current: NetworkConfiguration {
        #if DEBUG
        return .development
        #else
        return .production
        #endif
    }
} 