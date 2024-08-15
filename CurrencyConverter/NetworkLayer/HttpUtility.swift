//
//  HttpUtility.swift
//  CurrencyConverter
//
//  Created by Arun on 14/08/24.
//

import Foundation

final class HttpUtility {
    
    private init() { }
    
    static let shared = HttpUtility()
    
    func hit<T: Decodable>(_ request: RestAPIRequest) async throws -> T {
        
        guard let request = try prepareURLRequest(from: request) else { throw URLError(.badURL) }
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        if
            let httpResponse = response as? HTTPURLResponse,
            200...299 ~= httpResponse.statusCode {
            let model = try JSONDecoder().decode(T.self, from: data)
            return model
        }
        
        throw URLError(.badServerResponse)
    }
    
    private func prepareURLRequest(from request: RestAPIRequest) throws -> URLRequest? {
        let stringBaseUrl = request.baseUrl
        
        guard var url = URL(string: stringBaseUrl) else { return nil }
        url.append(path: request.path, directoryHint: .notDirectory)
        
        if let queryItems = request.queryItems {
            url.append(queryItems: queryItems)
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.httpMethod.rawValue
        urlRequest.allHTTPHeaderFields = request.headers
        
        if let body = request.body {
            urlRequest.httpBody = try JSONEncoder().encode(body)
        }
        
        return urlRequest
    }
}
