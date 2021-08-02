//
//  AlertViewComponent.swift
//  RandomWeather
//
//  Created by Said Rehouni on 2/8/21.
//

import Foundation
import UIKit

class AlertViewComponent {
    func showAlert(title: String?, message: String, handler: ((UIAlertAction) -> Void)?, viewController: UIViewController) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let actionDone = UIAlertAction(title: "Aceptar", style: .default, handler: handler)
        
        alertController.addAction(actionDone)
        
        viewController.present(alertController, animated: true, completion: nil)
    }
}
