//
//  NetworkRouter.swift
//  Movie Today
//
//  Created by Uladzislau Yatskevich on 25.12.23.
//

import Foundation

public typealias NetworkRouterCompletion = (_ data: Data?,_ response: URLResponse?,_ error: Error?)->()

protocol NetworkRouter: AnyObject {
    associatedtype EndPoint: EndpointType
    func request(_ route: EndPoint, completion: @escaping NetworkRouterCompletion)
}
