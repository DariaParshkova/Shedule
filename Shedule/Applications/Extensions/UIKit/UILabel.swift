//
//  UILabel.swift
//  Shedule
//
//  Created by Parshkova Daria on 09.07.2023.
//

import UIKit
extension UILabel {
    convenience init(text:String, font:UIFont?, alignment: NSTextAlignment) {
        self.init()
        self.text = text
        self.font = font
        self.textColor = .black
        self.textAlignment = alignment
        self.adjustsFontSizeToFitWidth = true
        self.translatesAutoresizingMaskIntoConstraints = false
        //self.backgroundColor = .lightGray
    }
}

