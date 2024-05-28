//
//  PressButtonProtocol.swift
//  Shedule
//
//  Created by Parshkova Daria on 10.07.2021.
//

import Foundation
protocol PressReadyTaskButtonProtocol : AnyObject {
    func readyButtonTapped(indexPath: IndexPath)
}
protocol SwitchRepeatProtocol: AnyObject {
    func switchRepeat(value: Bool)
}
