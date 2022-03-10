//
//  PersonModel.swift
//  DeathNoteApp
//
//  Created by Yuliya Martsenko on 25.01.2022.
//

import Foundation

struct PersonModel {
    var name: String
    var date: String
    var howToDie: String = "Hart Attack"
    
    init(name: String, date: String, howToDie: String?) {
        self.name = name
        self.date = date
        guard let howToDie = howToDie else {
            return
        }
        self.howToDie = howToDie
    }

}
