//
//  ViewController.swift
//  APIClient
//
//  Created by Olexandr Bondar on 20.06.18.
//  Copyright © 2018 User. All rights reserved.
//

import UIKit

struct TestParameters: ApiParametersProtocol {
    func convertToDictionary() -> [String : Any] {
        return ["test": test]
    }
    
    var test = ""
}

struct Test: Decodable {
    var test = ""
}

class ViewController: UIViewController, APIClientProtocol {
  
    var test: Test?
    
    var alertPresenter: AlertDisplayable {
        return self
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let parameters = TestParameters(test: "dsf")
        let testRequest = RequestGenerator<Test>(type: .get, encodingType: .json, endPoint: EndPoint.one, parameters: nil)
        
        fetch(request: testRequest) { [weak self] (test) in
            self?.test = test
        }
        
    }
}

