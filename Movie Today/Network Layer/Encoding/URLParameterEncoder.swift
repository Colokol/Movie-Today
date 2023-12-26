//
//  URLParameterEncoder.swift
//  Movie Today
//
//  Created by Uladzislau Yatskevich on 25.12.23.
//

import Foundation

enum NetworkError: Error {
    case errorEncode
    case connectionError
    case noData
    case decodingError(String)

    var localizedDescription: String {
        switch self {
            case .errorEncode:
                return "Parameter encoding failed"
            case .connectionError:
                return "Connection error"
            case .noData:
                return "No data received"
            case .decodingError(let message):
                return "Decoding error: \(message)"
        }
    }
}

public struct URLParameterEncoder: ParameterEncoder {
    public static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
        guard let url = urlRequest.url else { throw NetworkError.connectionError}

        if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false), !parameters.isEmpty {
            urlComponents.queryItems = [URLQueryItem]()
            for (key,value) in parameters {
                let queryItem = URLQueryItem(name: key, value: "\(value)")
                urlComponents.queryItems?.append(queryItem)
            }
            urlRequest.url = urlComponents.url
        }
        if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
            urlRequest.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
        }
    }

}
