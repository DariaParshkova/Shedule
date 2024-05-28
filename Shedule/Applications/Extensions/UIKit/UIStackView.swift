//
//  UIStackView.swift
//  Shedule
//
//  Created by Parshkova Daria on 09.07.2021.
//

import UIKit

extension UIStackView {
    convenience init(arrangedSubviews: [UIView], axis:NSLayoutConstraint.Axis, spacing: CGFloat, distribution: UIStackView.Distribution) {
        self.init(arrangedSubviews: arrangedSubviews)
        self.axis = axis
        self.spacing = spacing
        self.distribution = distribution
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
