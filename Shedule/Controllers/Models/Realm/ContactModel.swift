//
//  ContactModel.swift
//  Shedule
//
//  Created by Parshkova Daria on 28.07.2023.
//

import Foundation
import RealmSwift

class ContactModel: Object {
    
    @Persisted var contactsName = "Unknown"
    @Persisted var contactsPhone = "Unknown"
    @Persisted var contactsMail = "Unknown"
    @Persisted var contactsType = "Unknown"
    @Persisted var contactsImage: Data?
    
}
