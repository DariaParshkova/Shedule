//
//  TeachersViewController.swift
//  Shedule
//
//  Created by Parshkova Daria on 13.07.2021.
//

import UIKit
import RealmSwift

class TeachersViewController: UITableViewController {
    private let localRealm = try! Realm()
    private var contactsArray: Results<ContactModel>!
    private let teacherId = "teacherId"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        title = "Teachers"
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ContactsTableViewCell.self, forCellReuseIdentifier: teacherId)
        
        contactsArray = localRealm.objects(ContactModel.self).filter("contactsType = 'Teacher'")
        
    }
    private func setTeacher(teacher: String) {
        let sheduleOptions = self.navigationController?.viewControllers[1] as? SheduleOptionsTableViewController 
        sheduleOptions?.sheduleModel.sheduleTeacher = teacher //обращаемся к модели передаем  teacher котор получаем из ячейки
        sheduleOptions?.cellNameArray[2][0] = teacher //обновляем ячейку 2 секции индекса 0 в
        sheduleOptions?.tableView.reloadRows(at: [[2,0]], with: .none) //обновляеи ее в нашей таблицк
        self.navigationController?.popViewController(animated: true) //возвращаемся назад
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        contactsArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: teacherId, for: indexPath) as! ContactsTableViewCell
        let model = contactsArray[indexPath.row]
        cell.configure(model: model)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = contactsArray[indexPath.row]
        setTeacher(teacher: model.contactsName)
    }

   

}
