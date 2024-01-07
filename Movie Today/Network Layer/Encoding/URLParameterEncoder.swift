//
//  URLParameterEncoder.swift
//  Movie Today
//
//  Created by Uladzislau Yatskevich on 25.12.23.
//

import Foundation

enum NetworkError: Error {
    case errorEncode
    case noData
    case clientError
    case connectionError
    case serverError
    case decodingError(String)
    case unauthorised
    case limit

    var localizedDescription: String {
        switch self {
            case .errorEncode:
                return "Parameter encoding failed"
            case .noData:
                return "No data received"
            case .connectionError:
                return "Connection error"
            case .decodingError(let message):
                return "Decoding error: \(message)"
            case .clientError:
                return "Client Error: Bad Request"
            case .serverError:
                return "Server Error: Bad Gateway"
            case .unauthorised:
                return "Error API Token"
            case .limit:
                return "Превышен дневной лимит"
        }
    }
}

public struct URLParameterEncoder: ParameterEncoder {
    public static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
        guard let url = urlRequest.url else { throw NetworkError.connectionError}

        if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false), !parameters.isEmpty {
            urlComponents.queryItems = [URLQueryItem]()
            for (key, value) in parameters {
                if let arrayValue = value as? [Any] {
                    for element in arrayValue {
                        let queryItem = URLQueryItem(name: key, value: "\(element)")
                        urlComponents.queryItems?.append(queryItem)
                    }
                } else {
                    let queryItem = URLQueryItem(name: key, value: "\(value)")
                    urlComponents.queryItems?.append(queryItem)
                }
            }
            urlRequest.url = urlComponents.url
        }
        if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
            urlRequest.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
        }
    }

}
