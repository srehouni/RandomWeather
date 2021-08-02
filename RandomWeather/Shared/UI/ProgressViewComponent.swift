//
//  ProgressViewComponent.swift
//  RandomWeather
//
//  Created by Said Rehouni on 2/8/21.
//

import Foundation
import JGProgressHUD

class ProgressViewComponent {
    private var progress : JGProgressHUD = JGProgressHUD(style: .dark)
    
    func showProgress(show: Bool, title: String, view: UIView) {
        hideProgress()
        if show {
            showProgress(title: title, view: view)
        } else {
            hideProgress()
        }
    }
    
    private func showProgress(title: String, view: UIView) {
        progress.textLabel.text = title
        progress.show(in: view)
    }
    
    private func hideProgress() {
        progress.dismiss(animated: true)
    }
}
