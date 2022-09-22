//
//  UIViewController + Ext.swift
//  INDMoney Game
//
//  Created by Vivek Singh Mehta on 21/09/22.
//

import UIKit


extension UIViewController {
    
    func showAlertWithOk(Title: String?, message: String?) {
        let alert = UIAlertController(title: Title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func showAlertWithOneHandler(title: String?, message: String?, handler: @escaping((_ action: UIAlertAction) -> Void)) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: handler))
        present(alert, animated: true, completion: nil)
    }
    
    func showAlertWithYesHandler(type: UIAlertController.Style = .alert, title: String?, message: String?, handler: @escaping((_ action: UIAlertAction) -> Void)) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: type)
        alert.addAction(UIAlertAction(title: "Start a new game", style: .default, handler: handler))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
}
