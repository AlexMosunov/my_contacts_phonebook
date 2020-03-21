//
//  ContactDetails.swift
//  Contacts-list
//
//  Created by Alex Mosunov on 3/8/20.
//  Copyright © 2020 Alex Mosunov. All rights reserved.
//

import UIKit

class ContactDetailsVC: UIViewController {

    var contact: ContactModel?
    
    @IBOutlet weak var contactImageView: UIImageView!
    @IBOutlet weak var contactNameLabel: UILabel!
    @IBOutlet weak var contactPhoneNumber: UILabel!
    @IBOutlet weak var contactCity: UILabel!
    @IBOutlet weak var contactGroup: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    func setUI () {
        contactImageView.image = contact?.image
        contactNameLabel.text = contact?.fullName
        contactPhoneNumber.text = contact?.phoneNumber
        contactCity.text = contact?.city
        contactGroup.text = "#\(contact?.group ?? 0)"
    }


}
