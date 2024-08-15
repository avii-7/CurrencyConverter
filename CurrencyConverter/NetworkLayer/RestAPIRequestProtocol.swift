//
//  RestAPIRequestProtocol.swift
//  CurrencyConverter
//
//  Created by Arun on 14/08/24.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

protocol RestAPIRequest {
    
    var baseUrl: String { get }
    
    var path: String { get }
    
    var httpMethod: HTTPMethod { get }
    
    var queryItems: [URLQueryItem]? { get }
    
    var body: Encodable? { get }
    
    var headers: [String: String]? { get }
}

extension RestAPIRequest {
    
    var baseUrl: String {
        "https://openexchangerates.org/api"
    }
    
    var queryItems: [URLQueryItem]? {
        nil
    }
    
    var headers: [String: String]? {
        nil
    }
    
    var body: Encodable? {
        nil
    }
}
