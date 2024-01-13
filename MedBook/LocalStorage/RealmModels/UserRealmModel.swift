//
//  UserRealmModel.swift
//  MedBook
//
//  Created by Dheeraj Kumar Sharma on 13/01/24.
//

import RealmSwift

class UserRealmModel: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var name: String = ""
    @Persisted var email: String = ""
    @Persisted var currentCountry: String = ""
    @Persisted var password: String
    convenience init(name: String, email: String, currentCountry: String, password: String) {
        self.init()
        self.name = name
        self.email = email
        self.currentCountry = currentCountry
        self.password = password
    }
}

