//
//  TaskOptionTableView.swift
//  Shedule
//
//  Created by Parshkova Daria on 13.07.2023.
//

import UIKit
class TaskOptionTableView: UITableViewController {

    let idOptionsTaskCell = "idOptionsTaskCell"
    let idOptionsTasksHeader = "idOptionsTasksHeader"
    let headerNameArray = ["DATA","LESSON","TASK","COLOR"]
    let cellNameArray = ["Date","Lesson","Task",""]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = R.ColorsForBackground.indigo
        tableView.separatorStyle = .none
        tableView.bounces = false //yбираем функцию оттягивания таблицы
        tableView.register(OptionsTableViewCell.self, forCellReuseIdentifier:idOptionsTaskCell)
        tableView.register(HeaderOptionsTableViewCell.self, forHeaderFooterViewReuseIdentifier: idOptionsTasksHeader)
        title = "Options Tasks"
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        4
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return 1
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idOptionsTaskCell, for: indexPath) as!  OptionsTableViewCell
        cell.cellTasksConfigure(nameArray: cellNameArray, indexPath: indexPath)
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
                print(numberWeekday, date)
            }
            case 1: alertForCellName(label: cell.nameCellLabel, name: "Name Lesson", placeholder: "Enter name lesson")
            case 2: alertForCellName(label: cell.nameCellLabel, name: "Task", placeholder: "Enter task")
            case 3: pushControllers(vc: ColorTaskTableViewController())
            
            
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
    
