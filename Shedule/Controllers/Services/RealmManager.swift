//
//  RealmManager.swift
//  Shedule
//
//  Created by Parshkova Daria on 21.07.2023.
//

import RealmSwift
class RealmManeger {
    static let shared = RealmManeger()
    private init() {}
    
    let localRealm = try! Realm()
    
    func saveSheduleModel(model: SheduleModel) {
        try! localRealm.write {
            localRealm.add(model)
            print(Realm.Configuration.defaultConfiguration.fileURL )
        }
    }
    
}
