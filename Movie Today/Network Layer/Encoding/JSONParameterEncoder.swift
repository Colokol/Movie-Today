//
//  JSONParameterEncoder.swift
//  Movie Today
//
//  Created by Uladzislau Yatskevich on 25.12.23.
//

import Foundation

public struct JSONParameterEncoder:ParameterEncoder {
    public static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
        do{
            let jsonAsData = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            urlRequest.httpBody = jsonAsData
            if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
                urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            }
        } catch {
            throw NetworkError.errorEncode
        }
    }


}
