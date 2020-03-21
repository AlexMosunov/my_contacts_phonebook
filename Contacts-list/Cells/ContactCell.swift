//
//  ContactCell.swift
//  Contacts-list
//
//  Created by Alex Mosunov on 3/8/20.
//  Copyright © 2020 Alex Mosunov. All rights reserved.
//

import UIKit

class ContactCell: UITableViewCell {


    @IBOutlet weak var contactImageView: UIImageView!
    @IBOutlet weak var contactFullName: UILabel!
    @IBOutlet weak var contactPhoneNumber: UILabel!
    @IBOutlet weak var contactCity: UILabel!
    @IBOutlet weak var contactGroup: UILabel!
    
    
    
//    func setContact(contact: ContactModel) {
//        contactImageView.image = contact.image
//        contactFullName.text = contact.fullName
//        contactPhoneNumber.text = contact.phoneNumber
//        contactCity.text = contact.city
//        contactGroup.text = "Group: \(contact.group)"
//    }
    
}
