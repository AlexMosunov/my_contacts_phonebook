//
//  AddNewContactTVC.swift
//  Contacts-list
//
//  Created by Alex Mosunov on 3/19/20.
//  Copyright © 2020 Alex Mosunov. All rights reserved.
//

import UIKit

class AddNewContactTVC: UITableViewController {
    
    var contact: ContactModel?
    var contactAvatarImageName = ""
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var phoneNumberField: UITextField!
    @IBOutlet weak var cityField: UITextField!
    @IBOutlet weak var groupNumberPicker: UIPickerView!
    @IBOutlet var myTableView: UITableView!
    @IBOutlet weak var avatarImage: UIImageView!
    
    
    var delegate: ContactListScreenDelegate?
    
    var groupNumberPickerData: [Int] = []
    var selectedGroupNumber : Int?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        nameField.delegate = self
        phoneNumberField.delegate = self
        cityField.delegate = self
        
        myTableView.tableFooterView = UIView()
        
        setNumPicker(minNum: 1, maxNum: 100)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneTapped))
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        avatarImage.isUserInteractionEnabled = true
        avatarImage.addGestureRecognizer(tapGestureRecognizer)
        
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        
        let avatarStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let avatarVC = avatarStoryboard.instantiateViewController(withIdentifier: "ChooseAvatarCVC") as! ChooseAvatarCVC
        navigationController?.pushViewController(avatarVC, animated: true)
        
    }
    
    
    
    @objc func doneTapped() {
        
        var contactCity = ""
        let image = contactAvatarImageName
        
        guard let name = nameField.text, !name.isEmpty else {
            reportError(title: "Empty name field", message: "Please type name in the textfield")
            return
        }
        guard let phoneNumber = phoneNumberField.text, !phoneNumber.isEmpty else {
            reportError(title: "Empty phone number field", message: "Please type phone number in the textfield")
            return
        }
        guard let groupNum = selectedGroupNumber else {
            reportError(title: "No group number selection", message: "Please select the group number using wheel selector")
            return
        }
        if let city = cityField {
            contactCity = city.text ?? " "
        }
        
        let newContact = ContactModel(image: image, fullName: name, phoneNumber: phoneNumber, city: contactCity, group: groupNum)
        delegate?.update(contact: newContact)
        
        navigationController?.popViewController(animated: true)
    }
    
    
    func reportError(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    
    func setNumPicker(minNum: Int, maxNum: Int) {
        for num in minNum...maxNum {
            groupNumberPickerData.append(num)
        }
        groupNumberPicker.delegate = self
    }
    
    
    @IBAction func unwindToAddNewContact(_ sender: UIStoryboardSegue) {
        
        guard let chooseAvatarVC = sender.source as? ChooseAvatarCVC else { return }
        
        contactAvatarImageName = chooseAvatarVC.avatarImageName
        
        avatarImage.image = UIImage(named: contactAvatarImageName)
        avatarImage.backgroundColor = .white
        myTableView.reloadData()
    }
    
    
}


extension AddNewContactTVC: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return groupNumberPickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(groupNumberPickerData[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedGroupNumber = groupNumberPickerData[row]
    }
}



extension AddNewContactTVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //        resignFirstResponder()
        textField.endEditing(true)
        
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        view.endEditing(true)
    }
    
}

