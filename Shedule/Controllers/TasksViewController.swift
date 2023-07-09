//
//  TasksViewController.swift
//  Shedule
//
//  Created by Parshkova Daria on 07.07.2023.
//

import UIKit
import FSCalendar

class TasksViewController : UIViewController {
    var calendarHeightConstraint : NSLayoutConstraint!
    
    private var calendar : FSCalendar = {
        let calendar = FSCalendar()
        calendar.translatesAutoresizingMaskIntoConstraints = false
        return calendar
    }()
    let showHideButton : UIButton = {
        let button = UIButton()
        button.setTitle(R.Strings.Calendar.openCalendar, for: .normal)
        button.setTitleColor(UIColor.lightGray, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = R.Fonts.aveneirNextDemiBold(with: 14)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Shedule"
        calendar.delegate = self
        calendar.dataSource = self
        calendar.scope = .week
        setConstraints()
        showHideButton.addTarget(self, action: #selector(showHideButtonTapped), for: .touchUpInside)
        swipeAction()
    }
    @objc func showHideButtonTapped() {
        if calendar.scope == .week {
            calendar.setScope(.month, animated: true)
            showHideButton.setTitle(R.Strings.Calendar.closeCalendar, for: .normal)
        } else {
            calendar.setScope(.week, animated: true)
            showHideButton.setTitle(R.Strings.Calendar.openCalendar, for: .normal)
        }
    }
}
//MARK: FSCalendarDataSource , FSCalendarDelegate
extension TasksViewController : FSCalendarDataSource, FSCalendarDelegate {
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        calendarHeightConstraint.constant = bounds.height
        view.layoutIfNeeded() //для плавной анимации
    }
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print(date)
    }
    //MARK: SwipeGestureRecognizer
    func swipeAction() {
        let swipeUP = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        swipeUP.direction = .up
        calendar.addGestureRecognizer(swipeUP)
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        swipeDown.direction = .down
        calendar.addGestureRecognizer(swipeDown)
    }
    
    @objc func handleSwipe(gesture: UISwipeGestureRecognizer) {
        switch gesture.direction {
        case .up : showHideButtonTapped()
        case .down : showHideButtonTapped()
        default : break
        }
    }
    
}

//MARK: SetConstraints
extension TasksViewController {
    func setConstraints() {
        view.addSubview(calendar)
        //для открытия календаря при раскрытии его проностью
        calendarHeightConstraint = NSLayoutConstraint(item: calendar, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 300)
        calendar.addConstraint(calendarHeightConstraint)
        
        NSLayoutConstraint.activate([
            calendar.topAnchor.constraint(equalTo: view.topAnchor, constant: 90),
            calendar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            calendar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant:0 ),])
        view.addSubview(showHideButton)
        NSLayoutConstraint.activate([
            showHideButton.topAnchor.constraint(equalTo: calendar.bottomAnchor, constant: 0),
            showHideButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            showHideButton.widthAnchor.constraint(equalToConstant: 120),
            showHideButton.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
}
