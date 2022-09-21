//
//  GameRouter.swift
//  INDMoney Game
//
//  Created by Vivek Singh Mehta on 21/09/22.
//  
//

import Foundation
import UIKit

class GameRouter: PresenterToRouterGameProtocol {
    
    // MARK: Static methods
    static func createModule() -> UIViewController {
        
        let viewController = GameViewController()
        
        let presenter: ViewToPresenterGameProtocol & InteractorToPresenterGameProtocol = GamePresenter()
        
        viewController.presenter = presenter
        viewController.presenter?.router = GameRouter()
        viewController.presenter?.view = viewController
        viewController.presenter?.interactor = GameInteractor()
        viewController.presenter?.interactor?.presenter = presenter
        
        return viewController
    }
    
}
