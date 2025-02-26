//
//  ContactsTableViewController.swift
//  Shedule
//
//  Created by Parshkova Daria on 15.07.2021.
//

import UIKit
import RealmSwift

class ContactsViewController: UIViewController {
    private let segmentedControl : UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["Friends", "Teachers"])
        segmentedControl.selectedSegmentIndex = 0
        return segmentedControl
    }()
    
    private let tableView : UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = R.Colors.indigoForBackground.uiColor
        tableView.separatorStyle = .singleLine
        return tableView
    }()
    let idContactsCell = "idContactsCell"
    
    let searchController = UISearchController()
    
    private let localRealm = try! Realm()
    private var contactsArray : Results<ContactModel>!
    private var filteredArray : Results<ContactModel>!
    
    var searchBarIsEmpty : Bool {
        guard let text = searchController.searchBar.text else { return true}
        return text.isEmpty
    }
    
    var isFiltring: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Contacts"
        view.backgroundColor = .white
        
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        
        contactsArray = localRealm.objects(ContactModel.self).filter("contactsType = 'Friend'")
        
        tableView.delegate = self
        tableView.dataSource = self
        //tableView.bounces = false //yбираем функцию оттягивания таблицы
        tableView.register(ContactsTableViewCell.self, forCellReuseIdentifier:idContactsCell)
        setConstraints()
        
        segmentedControl.addTarget(self, action:#selector(segmentChanged) , for: .valueChanged)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
    }
    @objc private func segmentChanged() {
        if segmentedControl.selectedSegmentIndex == 0 {
            contactsArray = localRealm.objects(ContactModel.self).filter("contactsType = 'Friend'")
            tableView.reloadData()
        } else {
            contactsArray = localRealm.objects(ContactModel.self).filter("contactsType = 'Teacher'")
            tableView.reloadData()
        }
    }
    
    @objc func addButtonTapped() {
        let contactOption = ContactsOptionsTableViewController()
        navigationController?.pushViewController(contactOption, animated: true)
    }
    //для измненения данных уже в созданной ячейке (1)
    @objc func editingModel(contactModel: ContactModel) {
        let contactOption = ContactsOptionsTableViewController()
        contactOption.contactModel = contactModel
        contactOption.editModel = true
        contactOption.cellNameArray = [
            contactModel.contactsName,
            contactModel.contactsPhone,
            contactModel.contactsMail,
            contactModel.contactsType,
            ""
        ]
        contactOption.imageIsChanged = true
        navigationController?.pushViewController(contactOption, animated: true)
    }
     
}
//MARK: UITableViewDelegate, UITableViewDataSource
extension ContactsViewController : UITableViewDelegate, UITableViewDataSource {
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return (isFiltring ? filteredArray.count : contactsArray.count)
   }
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: idContactsCell, for: indexPath) as!  ContactsTableViewCell
       let model = (isFiltring ? filteredArray[indexPath.row] : contactsArray[indexPath.row])
       cell.configure(model: model)
       return cell
   }
   
   func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return 80
   }
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       //для изменения существующей ячейки (2)
       let model = contactsArray[indexPath.row]
       editingModel(contactModel: model)
   }
   
   func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
       let editingRow = contactsArray[indexPath.row]
       let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { _, _, completionHandler in
           RealmManager.shared.deleteContactModel(model: editingRow)
           tableView.reloadData()
       }
       return UISwipeActionsConfiguration(actions:[deleteAction])
   }
}
extension ContactsViewController : UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    private func filterContentForSearchText(_ searchText: String)  {
        filteredArray = contactsArray.filter("contactsName CONTAINS[cd] %@", searchText)
       
        tableView.reloadData()
    }
}


extension ContactsViewController {
    private func setConstraints() {
        let stackView = UIStackView(arrangedSubviews: [segmentedControl ,tableView], axis: .vertical, spacing: 0, distribution: .equalSpacing)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }
    
}
