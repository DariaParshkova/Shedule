//
//  SheduleViewController.swift
//  Shedule
//
//  Created by Parshkova Daria on 07.07.2023.
//

import UIKit
import FSCalendar
import RealmSwift


class SheduleViewControllerSheduleViewController : UIViewController {
    private var calendarHeightConstraint : NSLayoutConstraint!
    
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
    private let tableView : UITableView = {
        let tableView = UITableView()
        tableView.bounces = false // не будет прокрутки при маленьком колич строк
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    let localRealm = try! Realm()
    var sheduleArray : Results<SheduleModel>!   //здесь сохраняем все значения базы данных
    
    private let idSheduleCell = "idSheduleCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        title = "Shedule"
        //sheduleArray = localRealm.objects(SheduleModel.self)  //при загрузке экрана сразу получаем данные из бд
        calendar.delegate = self
        calendar.dataSource = self
        calendar.scope = .week
        setConstraints()
        showHideButton.addTarget(self, action: #selector(showHideButtonTapped), for: .touchUpInside)
        swipeAction()
        sheduleOnDay(date: Date())
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SheduleTableViewCell.self, forCellReuseIdentifier: idSheduleCell) //регистрируем ячейек
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationController?.tabBarController?.tabBar.scrollEdgeAppearance = navigationController?.tabBarController?.tabBar.standardAppearance //таббар для 13 версии xcode
    }
    @objc private func addButtonTapped() {
        let scheduleOption = SheduleOptionsTableViewController()
        navigationController?.pushViewController(scheduleOption, animated: true)
    }
    @objc private func showHideButtonTapped() {
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

extension SheduleViewControllerSheduleViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sheduleArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idSheduleCell, for: indexPath) as! SheduleTableViewCell
        let model = sheduleArray[indexPath.row]
        cell.configure(model: model)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
    
    
}

//MARK: FSCalendarDataSource , FSCalendarDelegate
extension SheduleViewControllerSheduleViewController : FSCalendarDataSource, FSCalendarDelegate {
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        calendarHeightConstraint.constant = bounds.height
        view.layoutIfNeeded() //для плавной анимации
    }
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        sheduleOnDay(date: date)
        
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
    private func sheduleOnDay(date: Date) {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.weekday], from: date) //берем значения из даты
        guard let weekday = components.weekday else { return }
        print(weekday)
        let dateStart = date
        let dateEnd : Date = {
            let components = DateComponents(day:1 , second: -1)
            return Calendar.current.date(byAdding: components, to: dateStart)! //! можно использовать так как дата есть всегда
        }()
        //пишем условие при выполнении которого будем получать необходимые данные
        let predicateRepeat = NSPredicate(format: "sheduleWeekday = \(weekday) AND sheduleRepeat = true")
        let predicateUnrepeat = NSPredicate(format: "sheduleRepeat = false AND sheduleDate BETWEEN %@", [dateStart, dateEnd])
        let compound = NSCompoundPredicate(type: .or, subpredicates: [predicateRepeat, predicateUnrepeat])
        
        sheduleArray = localRealm.objects(SheduleModel.self).filter(compound).sorted(byKeyPath: "sheduleTime")
        tableView.reloadData()
    }
    
}

//MARK: SetConstraints
extension SheduleViewControllerSheduleViewController {
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

