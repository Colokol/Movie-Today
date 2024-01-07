    //
    //  Router.swift
    //  Movie Today
    //
    //  Created by Uladzislau Yatskevich on 25.12.23.
    //

import Foundation

class Router<EndPoint: EndpointType>:NetworkRouter {
    private var task: URLSessionTask?

    func request(_ route: EndPoint, completion: @escaping NetworkRouterCompletion) {
        let session = URLSession.shared
        do {
            let request = try self.buildRequest(from: route)
            task = session.dataTask(with: request, completionHandler: { data, response, error in
                completion(data,response,error)
            })
        } catch {
            completion(nil, nil, error)
        }
        self.task?.resume()
    }

    func cancel() {
        self.task?.cancel()
    }

    fileprivate func buildRequest(from route: EndPoint) throws -> URLRequest {
        var request = URLRequest(url: route.baseURL.appendingPathComponent(route.path),
                                 cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                 timeoutInterval: 10.0)
        do {
            switch route.task {

                case .request:
                    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                case .requestParameters(bodyParameters: let bodyParameters, urlParameters: let urlParameters):
                    try configureParameters(bodyParameters: bodyParameters, urlParameters: urlParameters, request: &request)
                case .requestParametersAndHeaders(bodyParameters: let bodyParameters, urlParameters: let urlParameters, additionalHeaders: let additionalHeaders):
                    try self.addAdditionalHeaders(additionalHeader: additionalHeaders, request: &request)
                    try configureParameters(bodyParameters: bodyParameters, urlParameters: urlParameters, request: &request)
            }
        }

        return request
    }

    fileprivate func configureParameters(bodyParameters: Parameters? , urlParameters: Parameters? , request: inout URLRequest) throws {
        do {
            if let bodyParameters {
                try JSONParameterEncoder.encode(urlRequest: &request, with: bodyParameters)
            }
            if let urlParameters {
                try URLParameterEncoder.encode(urlRequest: &request, with: urlParameters)
            }
        } catch {
            throw error
        }
    }

    fileprivate func addAdditionalHeaders(additionalHeader: HTTPHeaders?, request: inout URLRequest) throws {
        guard let header = additionalHeader else {return}
        for (key,value) in header {
            request.setValue(value, forHTTPHeaderField: key)
        }
    }

}
