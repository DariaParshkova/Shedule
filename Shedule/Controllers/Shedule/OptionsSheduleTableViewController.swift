//
//  OptionsSheduleViewController.swift
//  Shedule
//
//  Created by Parshkova Daria on 10.07.2023.
//

import UIKit

class OptionsSheduleTableViewController: UITableViewController {

    let idOptionsSheduleCell = "idOptionsSheduleCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = R.Colors.green
        tableView.separatorStyle = .none
        tableView.register(OptionsSheduleTableViewCell.self, forCellReuseIdentifier:idOptionsSheduleCell )
        title = "Option Schedule"
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
        let cell = tableView.dequeueReusableCell(withIdentifier: idOptionsSheduleCell, for: indexPath) as! OptionsSheduleTableViewCell
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
   

}
