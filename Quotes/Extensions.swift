//
//  Extensions.swift
//  Quotes
//
//  Created by Calvin Alfrido on 16/12/21.
//

import UIKit

extension UIViewController {
    func hideKeyboard() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.resignKey))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func resignKey() {
        DispatchQueue.main.async {
            self.view.endEditing(true)
        }
    }
}
