//
//  UIViewController+Extension.swift
//  MedBook
//
//  Created by Dheeraj Kumar Sharma on 20/12/23.
//

import UIKit

extension UIViewController {
    
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func showAlert(_ title: String, message: String, actionButtonName: String = "OK", isDestructive: Bool = false, _ respondAction: @escaping (Bool)->()) {
        
        // creating the alert
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        // adding an action (button)
        alert.addAction(UIAlertAction(title: "\(actionButtonName)", style: UIAlertAction.Style.default, handler: { action in
            respondAction(true)
        }))
        
        if isDestructive {
            alert.addAction(UIAlertAction(title: "cancel", style: UIAlertAction.Style.default, handler: { action in
                respondAction(false)
            }))
        }
        
        // showing the alert
        self.present(alert, animated: true, completion: nil)
    }
    
}
