//
//  Extensions.swift
//  MovieBrowser
//
//  Created by manoj Singireddy on 10/27/21.
//  Copyright © 2021 Lowe's Home Improvement. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func showAlertInViewController(titleStr :String?, messageStr :String, okButtonTitle :String,response :((_ dismissedWithCancel: Bool) -> Void)? = nil) {
        
        DispatchQueue.main.async {
            let controller = UIAlertController(title: titleStr, message: messageStr, preferredStyle: .alert)
            let okAction = UIAlertAction(title: okButtonTitle, style: .default, handler: { (action) in
                if response != nil {
                    response!(true)
                }
            })
            controller.addAction(okAction)
            self.present(controller, animated: true, completion: nil)
        }
    }
}

extension Date{
    public func string(withFormat format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}
