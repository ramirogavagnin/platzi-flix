import Foundation

/// Concrete implementation of HTTPService using URLSession
final class URLSessionHTTPService: HTTPService {
    private let session: URLSession
    private let configuration: NetworkConfiguration
    private let decoder: JSONDecoder
    private let encoder: JSONEncoder
    
    init(
        configuration: NetworkConfiguration = .current,
        session: URLSession = .shared
    ) {
        self.configuration = configuration
        self.session = session
        
        // Configure JSON decoder
        self.decoder = JSONDecoder()
        self.decoder.dateDecodingStrategy = .iso8601
        
        // Configure JSON encoder
        self.encoder = JSONEncoder()
        self.encoder.dateEncodingStrategy = .iso8601
    }
    
    // MARK: - HTTPService Protocol Implementation
    
    func request<T: Codable>(endpoint: Endpoint) async throws -> T {
        let data = try await performRequest(endpoint: endpoint)
        
        do {
            let decodedResponse = try decoder.decode(T.self, from: data)
            return decodedResponse
        } catch {
            if configuration.enableLogging {
                print("❌ Decoding error: \(error)")
                if let jsonString = String(data: data, encoding: .utf8) {
                    print("📄 Response data: \(jsonString)")
                }
            }
            throw HTTPError.decodingError(error.localizedDescription)
        }
    }
    
    func request(endpoint: Endpoint) async throws {
        _ = try await performRequest(endpoint: endpoint)
    }
    
    func downloadData(from url: URL) async throws -> Data {
        do {
            let (data, response) = try await session.data(from: url)
            
            if let httpResponse = response as? HTTPURLResponse {
                try validateHTTPResponse(httpResponse, data: data)
            }
            
            return data
        } catch {
            if configuration.enableLogging {
                print("❌ Download error: \(error)")
            }
            throw mapError(error)
        }
    }
    
    // MARK: - Private Methods
    
    private func performRequest(endpoint: Endpoint) async throws -> Data {
        let request = try endpoint.asURLRequest()
        
        if configuration.enableLogging {
            logRequest(request)
        }
        
        do {
            let (data, response) = try await session.data(for: request)
            
            if let httpResponse = response as? HTTPURLResponse {
                if configuration.enableLogging {
                    logResponse(httpResponse, data: data)
                }
                try validateHTTPResponse(httpResponse, data: data)
            }
            
            return data
        } catch {
            if configuration.enableLogging {
                print("❌ Request error: \(error)")
            }
            throw mapError(error)
        }
    }
    
    private func validateHTTPResponse(_ response: HTTPURLResponse, data: Data) throws {
        switch response.statusCode {
        case 200...299:
            // Success, do nothing
            break
        case 400...499:
            let errorMessage = extractErrorMessage(from: data) ?? "Client error"
            switch response.statusCode {
            case 401:
                throw HTTPError.unauthorized
            case 403:
                throw HTTPError.forbidden
            case 404:
                throw HTTPError.notFound
            default:
                throw HTTPError.clientError(response.statusCode, errorMessage)
            }
        case 500...599:
            let errorMessage = extractErrorMessage(from: data) ?? "Server error"
            throw HTTPError.serverError(response.statusCode, errorMessage)
        default:
            throw HTTPError.unknown("Unexpected status code: \(response.statusCode)")
        }
    }
    
    private func extractErrorMessage(from data: Data) -> String? {
        if let jsonObject = try? JSONSerialization.jsonObject(with: data) as? [String: Any] {
            return jsonObject["message"] as? String ?? 
                   jsonObject["error"] as? String ?? 
                   jsonObject["detail"] as? String
        }
        return String(data: data, encoding: .utf8)
    }
    
    private func mapError(_ error: Error) -> HTTPError {
        if let httpError = error as? HTTPError {
            return httpError
        }
        
        if let urlError = error as? URLError {
            switch urlError.code {
            case .notConnectedToInternet, .networkConnectionLost:
                return .noInternetConnection
            case .timedOut:
                return .timeout
            case .badURL:
                return .invalidURL
            default:
                return .networkError(urlError.localizedDescription)
            }
        }
        
        return .unknown(error.localizedDescription)
    }
    
    // MARK: - Logging
    
    private func logRequest(_ request: URLRequest) {
        print("🚀 HTTP Request")
        print("   URL: \(request.url?.absoluteString ?? "N/A")")
        print("   Method: \(request.httpMethod ?? "N/A")")
        
        if let headers = request.allHTTPHeaderFields, !headers.isEmpty {
            print("   Headers:")
            headers.forEach { key, value in
                print("      \(key): \(value)")
            }
        }
        
        if let body = request.httpBody,
           let bodyString = String(data: body, encoding: .utf8) {
            print("   Body: \(bodyString)")
        }
    }
    
    private func logResponse(_ response: HTTPURLResponse, data: Data) {
        print("📥 HTTP Response")
        print("   Status: \(response.statusCode)")
        print("   URL: \(response.url?.absoluteString ?? "N/A")")
        
        if let responseString = String(data: data, encoding: .utf8) {
            print("   Body: \(responseString)")
        }
    }
} 