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
}
