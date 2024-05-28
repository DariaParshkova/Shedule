//
//  SheduleColorViewController.swift
//  Shedule
//
//  Created by Parshkova Daria on 13.07.2021.
//

import UIKit

class SheduleColorsViewController: UITableViewController {
    
    private let idOptionsColorCell = "idOptionsColorCell"
    private let idOptionsSheduleHeader = "idOptionsSheduleHeader"
    let headerNameArray = ["Pink","Yellow","Green","Cyan","Orange", "Grey", "Blue"]
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.bounces = false //yбираем функцию оттягивания таблицы
        tableView.register(ColorsTableViewCell.self, forCellReuseIdentifier:idOptionsColorCell)
        tableView.register(HeaderOptionsTableViewCell.self, forHeaderFooterViewReuseIdentifier: idOptionsSheduleHeader)
        title = "Color Schedule"
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        7
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 1
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idOptionsColorCell, for: indexPath) as! ColorsTableViewCell
        cell.cellConfigure(indexPath: indexPath)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: idOptionsSheduleHeader) as! HeaderOptionsTableViewCell
        header.headerConfigure(nameArray: headerNameArray, section: section)
        header.backgroundColor = .white
        return header
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0: setColor(color: R.Colors.pink.hexValue)
        case 1: setColor(color: R.Colors.yellow.hexValue)
        case 2: setColor(color: R.Colors.green.hexValue)
        case 3: setColor(color: R.Colors.cyan.hexValue)
        case 4: setColor(color: R.Colors.orange.hexValue)
        case 5: setColor(color: R.Colors.grey.hexValue)
        case 6: setColor(color: R.Colors.blue.hexValue)
        default :
            setColor(color: R.Colors.yellow.hexValue)
        }
    }
    private func setColor(color: String) {
        let sheduleOptions = self.navigationController?.viewControllers[1] as! SheduleOptionsTableViewController
        sheduleOptions.hexColorCell = color
        sheduleOptions.tableView.reloadRows(at: [[3,0]], with: .none)
        self.navigationController?.popViewController(animated: true)
    }

}
    

