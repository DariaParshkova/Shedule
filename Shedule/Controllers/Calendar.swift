//
//  SheduleViewController.swift
//  Shedule
//
//  Created by Parshkova Daria on 07.07.2023.
//

import UIKit
import FSCalendar

class SheduleViewController : UIViewController {
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
    let tableView : UITableView = {
        let tableView = UITableView()
        tableView.bounces = false // не будет прокрутки при маленьком колич строк
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    let idSheduleCell = "idSheduleCell"
    
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
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SheduleTableViewCell.self, forCellReuseIdentifier: idSheduleCell) //регистрируем ячейек
        
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
//MARK: UITableViewDelegate, UITableViewDataSource

extension SheduleViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idSheduleCell, for: indexPath) as! SheduleTableViewCell
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
    
    
}

//MARK: FSCalendarDataSource , FSCalendarDelegate
extension SheduleViewController : FSCalendarDataSource, FSCalendarDelegate {
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
extension SheduleViewController {
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
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: showHideButton.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: 0 )
        ])
    }
}

