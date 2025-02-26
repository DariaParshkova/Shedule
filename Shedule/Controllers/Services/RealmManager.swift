//
//  RealmManager.swift
//  Shedule
//
//  Created by Parshkova Daria on 21.07.2021.
//

import RealmSwift
class RealmManager {
    static let shared = RealmManager()
    private init() {}
    
    let localRealm = try! Realm()
    //SheduleModel
    func saveSheduleModel(model: SheduleModel) {
        try! localRealm.write {
            localRealm.add(model)
            //print(Realm.Configuration.defaultConfiguration.fileURL )
        }
    }
    func deleteSheduleModel(model: SheduleModel) {
        try! localRealm.write {
            localRealm.delete(model)
        }
    }
    //TaskModel
    func saveTaskModel(model: TaskModel) {
        try! localRealm.write {
            localRealm.add(model)
        }
    }
    func deleteTaskModel(model: TaskModel) {
        try! localRealm.write {
            localRealm.delete(model)
        }
    }
    func updateReadyButtonTaskModel(task: TaskModel, bool: Bool) {
        try! localRealm.write {
            task.taskReady = bool
        }
    } //перезаписываем одно значение 
    
    //ContactsModel
    func saveContactModel(model: ContactModel) {
        try! localRealm.write {
            localRealm.add(model)
        }
    }
    func deleteContactModel(model: ContactModel) {
        try! localRealm.write {
            localRealm.delete(model)
        }
    }
    //for editing
    func updateContactModel(model: ContactModel, nameArray: [String], imageData: Data?) {
        try! localRealm.write {
            model.contactsName = nameArray[0]
            model.contactsPhone = nameArray[1]
            model.contactsMail = nameArray[2]
            model.contactsType = nameArray[3]
            model.contactsImage = imageData
        }
    }
    
}
