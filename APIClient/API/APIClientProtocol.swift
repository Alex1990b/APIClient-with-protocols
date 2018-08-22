//
//  APIClient.swift
//  APIClient
//
//  Created by Olexandr Bondar on 20.06.18.
//  Copyright © 2018 User. All rights reserved.
//

import Alamofire

protocol APIClientProtocol {
    func fetch<T: APIRequestProtocol>(request: T, completion: @escaping (T.ResponseType) -> ())
    var  alertPresenter: AlertDisplayable { get }
}

extension APIClientProtocol {
    
    func fetch<T: APIRequestProtocol>(request: T, completion: @escaping (T.ResponseType) -> ()) {
        
        guard let url = request.endPoint.url else { return }
        
        Alamofire.request(url,method: getHTTPMethod(with: request) , parameters: request.parameters?.convertToDictionary(), encoding: getEncoding(with: request), headers: getHeader()).responseData { (calback) in
            
            self.handle(request: request, and: calback, completion: { (items) in
                completion(items!)
            })
        }
    }
}

private extension APIClientProtocol {
    
    func getHeader() -> [String: String]? {
        return ["ApiVersion" : "1.0"]
    }
    
    func getEncoding<T: APIRequestProtocol>(with request: T) -> ParameterEncoding {
        
        return request.encodingType == .json ? JSONEncoding.default : URLEncoding.default
    }
    
    func getHTTPMethod<T: APIRequestProtocol>(with request: T) -> HTTPMethod {
        switch request.type {
        case .post: return .post
        case .get: return .get
        case .put: return .put
        case .delete: return .delete
        }
    }
    
    func handle<T: APIRequestProtocol>(request: T, and callback: DataResponse<Data>, completion: (T.ResponseType?) -> () ) {
        
        if callback.response?.statusCode == 200 {
            if let data = callback.data {
                do {
                    let decoder = JSONDecoder()
                    
                    let items = try decoder.decode(T.ResponseType.self, from: data)
                    completion(items)
                    
                } catch let error {
                    alertPresenter.showAlert(with: error)
                }
            } else {
                alertPresenter.showAlert(with: callback.error!)
            }
        } else {
            alertPresenter.showAlert(with: callback.error!)
        }
    }
}






