//
//  TaskOptionTableView.swift
//  Shedule
//
//  Created by Parshkova Daria on 13.07.2023.
//

import UIKit
class TasksOptionsTableViewController: UITableViewController {

    private let idOptionsTaskCell = "idOptionsTaskCell"
    private let idOptionsTasksHeader = "idOptionsTasksHeader"
    
    let headerNameArray = ["DATA","LESSON","TASK","COLOR"]
    let cellNameArray = ["Date","Lesson","Task",""]
    private var taskModel = TaskModel()

    var hexColorCell = R.Colors.yellow.hexValue

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = R.Colors.indigoForBackground.uiColor
        tableView.separatorStyle = .none
        tableView.bounces = false //yбираем функцию оттягивания таблицы
        tableView.register(OptionsTableViewCell.self, forCellReuseIdentifier:idOptionsTaskCell)
        tableView.register(HeaderOptionsTableViewCell.self, forHeaderFooterViewReuseIdentifier: idOptionsTasksHeader)
        title = "Options Tasks"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveButtonTapped))
        
    }
    @objc func saveButtonTapped() {
        if taskModel.taskDate == nil || taskModel.taskName == "Unknown" {
            alertOk(title: "Error", message: "fill in the fields : Date,Lesson")
        } else {
            taskModel.taskColor = hexColorCell
            RealmManager.shared.saveTaskModel(model: taskModel)
            taskModel = TaskModel() //опустошаем модель для след задачи
            alertOk(title: "Success", message: nil)
            hexColorCell = R.Colors.yellow.hexValue
            tableView.reloadData()
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundColor = R.Colors.indigoForBackground.uiColor
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        4
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return 1
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idOptionsTaskCell, for: indexPath) as!  OptionsTableViewCell
        cell.cellTasksConfigure(nameArray: cellNameArray, indexPath: indexPath, hexColor: hexColorCell)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: idOptionsTasksHeader) as! HeaderOptionsTableViewCell
        header.headerConfigure(nameArray: headerNameArray, section: section)
        return header
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! OptionsTableViewCell
            switch indexPath.section {
            case 0: alertDate(label: cell.nameCellLabel) { (numberWeekday, date) in
                self.taskModel.taskDate = date
            }
            case 1: alertForCellName(label: cell.nameCellLabel, name: "Name Lesson", placeholder: "Enter name lesson") { text in
                self.taskModel.taskName = text
            }
            case 2: alertForCellName(label: cell.nameCellLabel, name: "Description Task", placeholder: "Enter description task") { text in
                self.taskModel.taskDescriptionName = text
            }
            case 3: pushControllers(vc: TasksColorsTableViewController())
         default :
        print("Tap optionsTableView")
    }
  }
    func pushControllers(vc: UIViewController) {
        let viewController = vc
        navigationController?.navigationBar.topItem?.title = "Options"
        navigationController?.pushViewController(viewController, animated: true)
    }
}
    
