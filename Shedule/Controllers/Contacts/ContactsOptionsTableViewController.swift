//
//  ContactOptionTableViewController.swift
//  Shedule
//
//  Created by Parshkova Daria on 15.07.2023.
//

import UIKit

class ContactsOptionsTableViewController: UITableViewController {
    private let idOptionsContactCell = "idOptionsContactCell"
    private let idOptionsContactHeader = "idOptionsContactHeader"
    
    let headerNameArray = ["NAME","PHONE","MAIL","TYPE","CHOOSE IMAGE"]
    let cellNameArray = ["Name","Phone","Mail","Type",""]
    
    private var imageIsChanged = false
    private var contactModel = ContactModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Options Contacts"
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = R.Colors.indigoForBackground.uiColor
        tableView.separatorStyle = .none
        tableView.bounces = false //yбираем функцию оттягивания таблицы
        tableView.register(OptionsTableViewCell.self, forCellReuseIdentifier:idOptionsContactCell)
        tableView.register(HeaderOptionsTableViewCell.self, forHeaderFooterViewReuseIdentifier: idOptionsContactHeader)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveButtonTapped))
    }
    @objc private func saveButtonTapped() {
        if contactModel.contactsName == "Unknown" || contactModel.contactsType == "Unknown" {
            alertOk(title: "Error", message: "Fill in the fields: Name and Type")
        } else {
            setImageModel()
            
            RealmManager.shared.saveContactModel(model: contactModel)
            contactModel = ContactModel()
            
            alertOk(title: "Success", message: nil)
            tableView.reloadData()
        }
    }
    @objc private func setImageModel() {
        if imageIsChanged {
            let cell = tableView.cellForRow(at: [4,0]) as! OptionsTableViewCell
            
            let image = cell.backgroundViewCell.image
            guard let imageData = image?.pngData() else { return } //сохраняем изображение в виде даты
            contactModel.contactsImage = imageData
            
            cell.backgroundViewCell.contentMode = .scaleAspectFit
            imageIsChanged = false //чтобы не сохранялось дефолтное изображение
        } else {
            contactModel.contactsImage = nil
        }
    }
    
    //MARK: UITableViewDelegate, UITableViewDataSource
    override func numberOfSections(in tableView: UITableView) -> Int {
        5
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idOptionsContactCell, for: indexPath) as! OptionsTableViewCell
        cell.cellContactConfigure(nameArray: cellNameArray, indexPath: indexPath)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section == 4 ? 200 : 44
    }
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: idOptionsContactHeader) as! HeaderOptionsTableViewCell
        header.headerConfigure(nameArray: headerNameArray, section: section)
        return header
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! OptionsTableViewCell
        switch indexPath.section {
        case 0 : alertForCellName(label: cell.nameCellLabel, name: "Name Contact", placeholder: "Enter name contact") { text in
            self.contactModel.contactsName = text
        }
        case 1 : alertForCellName(label: cell.nameCellLabel, name: "Phone Contact", placeholder: "Enter phone contact") { text in
            self.contactModel.contactsPhone = text
        }
        case 2 : alertForCellName(label: cell.nameCellLabel, name: "Mail Contact", placeholder: "Enter mail contact") { text in
            self.contactModel.contactsMail = text
        }
        case 3 : alertFriendOrTecher(label: cell.nameCellLabel) { (type) in
            self.contactModel.contactsType = type
        }
        case 4: alertPhotoOrCamera { source in
            self.chooseImagePicker(source: source)
        }
        default :
            print("Tap contact table view")
        }
        
  }
    func pushControllers(vc: UIViewController) {
        let viewController = vc
        navigationController?.navigationBar.topItem?.title = "Contacts"
        navigationController?.pushViewController(viewController, animated: true)
    }
}
extension ContactsOptionsTableViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func chooseImagePicker(source: UIImagePickerController.SourceType) {
        if UIImagePickerController.isSourceTypeAvailable(source) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true //разрешение на редактирование неподвижного изображения
            imagePicker.sourceType = source
            present(imagePicker, animated: true)
        }
    }
    //присваиваем изображение в ячейку - UIImageView
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let cell = tableView.cellForRow(at: [4,0]) as! OptionsTableViewCell
        cell.backgroundViewCell.image = info[.editedImage] as? UIImage
        cell.backgroundViewCell.contentMode = .scaleAspectFill
        cell.backgroundViewCell.clipsToBounds = true
        imageIsChanged = true // при назначении изображения в ячейке меняеям на тру
        dismiss(animated: true)
    }
}
