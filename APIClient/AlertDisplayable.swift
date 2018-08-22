//
//  AlertDisplayable.swift
//  APIClient
//
//  Created by Alex on 22.08.18.
//  Copyright © 2018 User. All rights reserved.
//

import UIKit

protocol AlertDisplayable {
    func showAlert(with error: Error)
}

extension AlertDisplayable where Self: UIViewController {
    func showAlert(with error: Error) {
        //TO DO
    }
}
