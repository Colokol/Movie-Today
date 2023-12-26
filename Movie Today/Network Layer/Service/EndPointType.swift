//
//  EndPointType.swift
//  Movie Today
//
//  Created by Uladzislau Yatskevich on 25.12.23.
//

import Foundation

protocol EndpointType {
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask { get }
    var headers: HTTPHeaders? { get }
}
