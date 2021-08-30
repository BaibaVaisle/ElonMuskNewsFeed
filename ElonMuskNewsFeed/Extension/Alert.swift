//
//  Alert.swift
//  ElonMuskNewsFeed
//
//  Created by baiba.vaisle on 28/08/2021.
//

import UIKit

extension UIViewController {
    func basicAlert(title: String?, message: String?){
        
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.view.tintColor = UIColor.black
            alert.view.backgroundColor = UIColor.orange
            alert.view.layer.cornerRadius = 40
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
            
        }
        
    }
}
