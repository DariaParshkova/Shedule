//
//  SheduleViewController.swift
//  Shedule
//
//  Created by Parshkova Daria on 07.07.2023.
//

import UIKit
import FSCalendar

class SheduleViewController : UIViewController {
    private var calendar : FSCalendar = {
        let calendar = FSCalendar()
        calendar.translatesAutoresizingMaskIntoConstraints = false
        return calendar
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Shedule"
        setConstraints()
    }
}
//MARK: SetConstraints
extension SheduleViewController {
    func setConstraints() {
        view.addSubview(calendar)
        NSLayoutConstraint.activate([
            calendar.topAnchor.constraint(equalTo: view.topAnchor, constant: 90),
            calendar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            calendar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant:0 ),
            calendar.heightAnchor.constraint(equalToConstant: 300)])
    }
}

