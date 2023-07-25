//
//  extUIcolor.swift
//  Shedule
//
//  Created by Parshkova Daria on 10.07.2023.
//

import Foundation
import UIKit

extension UIColor {
    // Создание UIColor из строки с HEX значением (например, "#RRGGBB" или "RRGGBB")
    convenience init?(hexString: String) {
        var formattedString = hexString.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // Проверяем и удаляем "#" из строки, если присутствует
        if formattedString.hasPrefix("#") {
            formattedString.remove(at: formattedString.startIndex)
        }
        
        // Проверяем, что длина строки корректна
        guard formattedString.count == 6 else {
            return nil
        }
        
        // Парсим значения RGB из строки
        var rgbValue: UInt64 = 0
        Scanner(string: formattedString).scanHexInt64(&rgbValue)
        
        // Создаем UIColor из RGB значения
        let red = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgbValue & 0x0000FF) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
    
    func toHexString() -> String? {
        guard let components = self.cgColor.components, components.count >= 3 else {
            return nil
        }
        
        let r = Float(components[0])
        let g = Float(components[1])
        let b = Float(components[2])
        
        let hexString = String(format: "#%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255))
        return hexString
    }
}

