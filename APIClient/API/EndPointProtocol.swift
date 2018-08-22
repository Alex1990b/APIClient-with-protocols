//
//  File.swift
//  APIClient
//
//  Created by Olexandr Bondar on 20.06.18.
//  Copyright © 2018 User. All rights reserved.
//

import Foundation

protocol EndPointProtocol {
    var url: URL? { get}
}

extension EndPointProtocol {
    var baseURL: String {
        return "baseUrl"
    }
}

enum EndPoint: String, EndPointProtocol {
   
    case one = "one"
    case two = "two"
    
    var url: URL? {
        switch self {
        case .one: return URL(string: baseURL + "one")
        case .two: return URL(string: baseURL + "two")
        }
    }
}



