//
//  ContactInfo.swift
//  Contacts-list
//
//  Created by Alex Mosunov on 3/8/20.
//  Copyright © 2020 Alex Mosunov. All rights reserved.
//

import UIKit

class ContactModel {
    
    var image: String
    var fullName: String
    var phoneNumber: String
    var city: String
    var group: Int
    
    init(image: String, fullName: String, phoneNumber: String, city: String, group: Int) {
        self.image = image
        self.fullName = fullName
        self.phoneNumber = phoneNumber
        self.city = city
        self.group = group
    }
    
    let avatarImageNames = ["avatar1",
                            "avatar2",
                            "avatar3",
                            "avatar1",
                            "avatar2",
                            "avatar3",
                            "avatar1",
                            "avatar2",
                            "avatar3",
                            "avatar1",
                            "avatar2",
                            "avatar3",
                            "avatar1",
                            "avatar2",
                            "avatar3",
                            "avatar1",
                            "avatar2",
                            "avatar3",
                            "avatar1",
                            "avatar2",
                            "avatar3",
                            "avatar1",
                            "avatar2",
                            "avatar3"]
    
}
