//
//  AlertOk.swift
//  Shedule
//
//  Created by Parshkova Daria on 25.07.2023.
//

import UIKit
extension UIViewController {
    func alertOk(title: String) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "OK", style: .default)
        
        alert.addAction(ok)
        
        present(alert, animated: true, completion: nil)
        
    }
}
