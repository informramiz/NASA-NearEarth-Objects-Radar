//
//  UIViewController+Extras.swift
//  NASA-NeoWs
//
//  Created by Apple on 16/03/2020.
//  Copyright © 2020 RR Inc. All rights reserved.
//

import Foundation
import UIKit
extension UIViewController {
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { action in
            self.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
    }
    
    func showErrorAlert(message: String) {
        showAlert(title: "Error", message: message)
    }
}
