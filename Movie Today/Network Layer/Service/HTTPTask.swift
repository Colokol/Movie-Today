//
//  HTTPTask.swift
//  Movie Today
//
//  Created by Uladzislau Yatskevich on 25.12.23.
//

import Foundation

public typealias HTTPHeaders = [String:String]

public enum HTTPTask {
    case request

    case requestParameters(bodyParameters: Parameters?, urlParameters: Parameters?)

    case requestParametersAndHeaders(bodyParameters: Parameters?, urlParameters: Parameters?, additionalHeaders: HTTPHeaders?)
}
