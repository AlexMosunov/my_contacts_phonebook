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
    var contactAvatarImageName = #imageLiteral(resourceName: "Photo")
    
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
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(doneTapped))
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        avatarImage.isUserInteractionEnabled = true
        avatarImage.addGestureRecognizer(tapGestureRecognizer)
        
    }
    
    // Choosing image - from photo library or avatar library
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        
        
        let actionSheet = UIAlertController(title: nil,
                                            message: nil,
                                            preferredStyle: .actionSheet)
        
        let photo = UIAlertAction(title: "Photo Library", style: .default) { _ in
            self.chooseImagePicker(source: .photoLibrary)
        }
        
        let avatarMenu = UIAlertAction(title: "Avatar Library", style: .default) { _ in
            let avatarStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let avatarVC = avatarStoryboard.instantiateViewController(withIdentifier: "ChooseAvatarCVC") as! ChooseAvatarCVC
            
            avatarVC.selectionDelegate = self
            
            self.navigationController?.pushViewController(avatarVC, animated: true)
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        actionSheet.addAction(photo)
        actionSheet.addAction(avatarMenu)
        actionSheet.addAction(cancel)
        
        present(actionSheet, animated: true, completion: nil)
    }
    
    
    // done button tapped, checking textfields completion, alerting user in case of non-completion
    
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
    
    
    // seting group number picker
    
    func setNumPicker(minNum: Int, maxNum: Int) {
        for num in minNum...maxNum {
            groupNumberPickerData.append(num)
        }
        groupNumberPicker.delegate = self
    }
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        view.endEditing(true)
    }
    
    
}

//MARK: - Group number picker
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


//MARK: - Text Field Delegate

extension AddNewContactTVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //        resignFirstResponder()
        textField.endEditing(true)
        
        return true
    }
    
    
}


//MARK: - Image Picker Controller Delegate

extension AddNewContactTVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func chooseImagePicker(source: UIImagePickerController.SourceType) {
        
        if UIImagePickerController.isSourceTypeAvailable(source) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = source
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        avatarImage.image = info[.editedImage] as? UIImage
        avatarImage.contentMode = .scaleAspectFill
        avatarImage.clipsToBounds = true
        
        if let chosenImage = info[.editedImage] as? UIImage {
            contactAvatarImageName = chosenImage
        }
        
 
        print(contactAvatarImageName)
        
        dismiss(animated: true, completion: nil)
    }
}


//MARK: - Choose Avatar Delegate

extension AddNewContactTVC: ChooseAvatarDelegate {
    func didChooseAvatar(avatar: UIImage) {
        avatarImage.image = avatar
        contactAvatarImageName = avatar
        avatarImage.backgroundColor = .white
    }
    
    
}
