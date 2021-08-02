//
//  Componentable.swift
//  RandomWeather
//
//  Created by Said Rehouni on 2/8/21.
//

import Foundation
import UIKit

public protocol Componentable {
    
    associatedtype GenericVM
    
    static var storyboardName: String { get }
    
    var viewModel: GenericVM { get set }
}

public protocol ViewModelType {}

extension Componentable {
    
    public static func create<GenericVC: Componentable>(viewModel: GenericVM) -> GenericVC where GenericVC: UIViewController, GenericVM == GenericVC.GenericVM {
        
        let storyboard = UIStoryboard(name: storyboardName, bundle: Bundle(for: GenericVC.self))
        
        if var viewController = storyboard.instantiateInitialViewController() as? GenericVC {
            viewController.viewModel = viewModel
            return viewController as GenericVC
        } else {
            fatalError("Could not create \(String(describing: GenericVC.self))")
        }
    }
}
