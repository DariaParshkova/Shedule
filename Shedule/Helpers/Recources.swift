//
//  Recources.swift
//  Shedule
//
//  Created by Parshkova Daria on 09.07.2023.
//

import UIKit
enum R {
    enum Strings {
        enum Calendar {
            static let openCalendar = "Open calendar"
            static let closeCalendar = "Close calendar"
        }
    }
    
    enum Fonts {
        static func aveneirNextDemiBold(with size: CGFloat) -> UIFont {
            UIFont(name: "Avenir Next Demi Bold", size: size) ?? UIFont()
        }
        static func aveneirNext(with size: CGFloat) -> UIFont {
            UIFont(name: "Avenir Next", size: size) ?? UIFont()
        }
    }
    enum Colors: String {
        case pink = "#FCE4EC"
        case yellow = "#FFFFD5"
        case green = "#E8F5E9"
        case cyan = "#EDFFFE"
        case orange = "#FBE9E7"
        case grey = "#ECEFF1"
        case blue = "E3F2FD"
        
        
        case greenSwitch = "#66BB6A"
        case blueForEmail = "#42A5F5"
        case indigoForBackground =  "#E8EAF6"
        case white = "#FFFFFF"
        
        var hexValue: String {
               return self.rawValue
           }

           var uiColor: UIColor? {
               return UIColor(hexString: self.rawValue)
           }
    }
    
}
