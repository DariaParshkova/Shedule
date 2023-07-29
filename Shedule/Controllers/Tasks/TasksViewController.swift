//
//  TasksViewController.swift
//  Shedule
//
//  Created by Parshkova Daria on 07.07.2023.
//

import UIKit
import FSCalendar
import RealmSwift

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
    let tableView : UITableView = {
        let tableView = UITableView()
        tableView.bounces = false // не будет прокрутки при маленьком колич строк
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private let idTasksCell = "idTasksCell"
    
    private let localRealm = try! Realm()
    private var taskArray: Results<TaskModel>! //обращаемся к этой модели и хотим записать их в taskArray
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData() //перезагрузка страницы при создании задачи
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Tasks"
        
        calendar.delegate = self
        calendar.dataSource = self
        calendar.scope = .week
        
        setConstraints()
        swipeAction()
        setTaskOnDay(date: calendar.today!)
        
        showHideButton.addTarget(self, action: #selector(showHideButtonTapped), for: .touchUpInside)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TasksTableViewCell.self, forCellReuseIdentifier: idTasksCell) //регистрируем ячейек
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
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
    @objc func addButtonTapped() {
        let taskOption = TasksOptionsTableViewController()
        navigationController?.pushViewController(taskOption, animated: true)
    }
    
}
//MARK: UITableViewDelegate, UITableViewDataSource

extension TasksViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        taskArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idTasksCell, for: indexPath) as! TasksTableViewCell
        cell.cellTaskDelegate = self
        cell.index = indexPath
        let model = taskArray[indexPath.row]
        cell.configure(model: model)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let editingRow = taskArray[indexPath.row]
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { _,_, completionHandler in
            RealmManager.shared.deleteTaskModel(model: editingRow)
            tableView.reloadData()
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
        
    }
    
    
    
}
//MARK: PressReadyTaskButtonProtocol
extension TasksViewController : PressReadyTaskButtonProtocol {
    func readyButtonTapped(indexPath: IndexPath) {
        let task = taskArray[indexPath.row] //создаю экземпляр модели и выбираю ее по indexPath
        RealmManager.shared.updateReadyButtonTaskModel(task: task, bool: !task.taskReady) //вместе с нажатием на кнопку меняется и значение в модели bool
        tableView.reloadData()
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
    private func setTaskOnDay(date: Date) {
        let dateStart = date
        let dateEnd: Date = {
            let components = DateComponents(day: 1, second: -1)
            return Calendar.current.date(byAdding: components, to: dateStart)!
        }()
        taskArray = localRealm.objects(TaskModel.self).filter("taskDate BETWEEN %@", [dateStart, dateEnd])
        tableView.reloadData() //обновление таблицы при выборе числа в календаре 
        
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
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: showHideButton.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: 0 )
        ])
    }
}
