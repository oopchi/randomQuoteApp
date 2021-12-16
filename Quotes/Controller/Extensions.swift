//
//  Extensions.swift
//  Quotes
//
//  Created by Calvin Alfrido on 16/12/21.
//

import UIKit

extension UIView {
    func hideKeyboard() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = true
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
