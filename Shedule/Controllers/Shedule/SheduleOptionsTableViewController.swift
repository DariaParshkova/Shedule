//
//  OptionsSheduleViewController.swift
//  Shedule
//
//  Created by Parshkova Daria on 10.07.2021.
//

import UIKit

class SheduleOptionsTableViewController: UITableViewController {

    private let idOptionsSheduleCell = "idOptionsSheduleCell"
    private let idOptionsSheduleHeader = "idOptionsSheduleHeader"
    
    let headerNameArray = ["DATA AND TIME","LESSON","TEACHER","COLOR","PERIOD"]
    var cellNameArray = [["Date","Time"],
                         ["Name","Type", "Building body", "Audience"],
                         ["Teacher Name"],
                         [""],
                         ["Repeat every 7 days"]]
    
    var sheduleModel = SheduleModel()
    
    var hexColorCell = R.Colors.yellow.hexValue
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //view.backgroundColor = .white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.bounces = false //yбираем функцию оттягивания таблицы
        tableView.register(OptionsTableViewCell.self, forCellReuseIdentifier:idOptionsSheduleCell)
        tableView.register(HeaderOptionsTableViewCell.self, forHeaderFooterViewReuseIdentifier: idOptionsSheduleHeader)
        title = "Schedule"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveButtonTapped))
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundColor = R.Colors.indigoForBackground.uiColor
        //view.backgroundColor = UIColor(hexString: "#E8EAF6")
        // Установите другие цвета и настройки элементов интерфейса перед отображением
    }
    
    @objc private func saveButtonTapped() {
        if sheduleModel.sheduleDate == nil || sheduleModel.sheduleTime == nil  || sheduleModel.sheduleName == "Unknown" {
            alertOk(title: "Error", message: "fill in the fields : Date, Time, Name")
        } else {
            sheduleModel.sheduleColor = hexColorCell
            RealmManager.shared.saveSheduleModel(model: sheduleModel)
            sheduleModel = SheduleModel() // обновление модели после сохранения фиксим баг
            alertOk(title: "Success", message: nil) 
            hexColorCell = R.Colors.yellow.hexValue //изменение цвета на прежний после сохранения
            cellNameArray[2][0] = "Teacher Name"
            tableView.reloadData() // обновляет ячейки при сохранении
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        5
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0 : return 2
        case 1 : return 4
        case 2 : return 1
        case 3 : return 1
        default : return 1
        }
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idOptionsSheduleCell, for: indexPath) as! OptionsTableViewCell
        cell.cellSheduleConfigure(nameArray: cellNameArray, indexPath: indexPath, hexColor: hexColorCell)
        cell.switchRepeatDelegate = self
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: idOptionsSheduleHeader) as! HeaderOptionsTableViewCell
        header.headerConfigure(nameArray: headerNameArray, section: section)
        return header
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! OptionsTableViewCell
        switch indexPath {
        case [0,0] :
            alertDate(label: cell.nameCellLabel) { (numberWeekday, date) in
            self.sheduleModel.sheduleDate = date //записываем данные в бд
            self.sheduleModel.sheduleWeekday = numberWeekday
        }
        case [0,1] :
            alertTime(label: cell.nameCellLabel) { (time) in
            self.sheduleModel.sheduleTime = time
        }
            
        case [1,0] :
            alertForCellName(label: cell.nameCellLabel, name: "Name Lesson", placeholder: "Enter name lesson") { text in
                self.sheduleModel.sheduleName = text
        }
        case [1,1] :
            alertForCellName(label: cell.nameCellLabel, name: "Type lesson", placeholder: "Enter type lesson") { text in
                self.sheduleModel.sheduleType = text
        }
        case [1,2] :
            alertForCellName(label: cell.nameCellLabel, name: "Building number", placeholder: "Enter number of building") { text in
                self.sheduleModel.sheduleBuilding = text
        }
        case [1,3] :
            alertForCellName(label: cell.nameCellLabel, name: "Audience number", placeholder: "Enter number of audience") { text in
                self.sheduleModel.sheduleAudience = text
        }
    
        case [2,0] : pushControllers(vc: TeachersViewController())
        case [3,0] : pushControllers(vc: SheduleColorsViewController())
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
    
   
extension SheduleOptionsTableViewController : SwitchRepeatProtocol {
    func switchRepeat(value: Bool) {
        sheduleModel.sheduleRepeat = value
    }
    
    
}
