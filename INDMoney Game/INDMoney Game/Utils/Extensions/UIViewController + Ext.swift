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
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
}
