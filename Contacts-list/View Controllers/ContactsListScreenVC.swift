//
//  ContactsListScreen.swift
//  Contacts-list
//
//  Created by Alex Mosunov on 3/8/20.
//  Copyright © 2020 Alex Mosunov. All rights reserved.
//

import UIKit



protocol ContactListScreenDelegate {
    func update(contact: ContactModel)
}


class ContactsListScreenVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    
    // Contacts Model array with lisr of 3 initial contacts for demo purposes
    var contacts: [ContactModel] = [
        ContactModel(image: UIImage(named: "avatar1")!, fullName: "Liza Brown", phoneNumber: "095-111-23-22", city: "New York", group: 2),
        ContactModel(image: UIImage(named: "avatar2")!, fullName: "Jack Smith", phoneNumber: "095-111-23-23", city: "Paris", group: 4),
        ContactModel(image: UIImage(named: "avatar3")!, fullName: "Eduard Petrov", phoneNumber: "095-111-23-24", city: "Odessa", group: 10)
        
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        // adding navigation bar buttons
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(filterTapped))
    }
    
    // addTapped bar button
    @objc func addTapped() {
        performSegue(withIdentifier: "goToAddContact", sender: nil)
    }
    
    // filterTapped bar button - filters alphabetically
    @objc func filterTapped() {
        
        let sortedContacts = contacts.sorted{ $0.fullName < $1.fullName }
        
        contacts = sortedContacts
        tableView.reloadData()
        
    }
    
    
    // segues preparation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "goToDetails" {
            let destVC = segue.destination as! ContactDetailsVC
            destVC.contact = sender as? ContactModel
            
        }
        
        if segue.identifier == "goToAddContact" {
            let destVC = segue.destination as! AddNewContactTVC
            destVC.delegate = self
        }
    }
    
    
    
}

//MARK: - table view delegate & datasource

extension ContactsListScreenVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCell") as! ContactCell
        
        let contact = contacts[indexPath.row]
        
        cell.contactCity.text = contact.city
        cell.contactFullName.text = contact.fullName
        cell.contactGroup.text = "Group: \(contact.group)"
        cell.contactPhoneNumber.text = contact.phoneNumber
        
        cell.contactImageView.image = contact.image
        cell.contactImageView.layer.cornerRadius = cell.contactImageView.frame.size.height / 2
        cell.contactImageView.clipsToBounds = true
        
        
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let contact = contacts[indexPath.row]
        performSegue(withIdentifier: "goToDetails", sender: contact)
    }
    
    
    
    // deleting contact by swiping left and asking whether user is sure to delete the contact by popping UIAlert
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let alert = UIAlertController(title: nil, message: "Are you sure you want to delete this contact?", preferredStyle: .alert)
            let yesAction = UIAlertAction(title: "Yes", style: .destructive) { _ in
                self.contacts.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            let noAction = UIAlertAction(title: "No", style: .default, handler: nil)
            alert.addAction(yesAction)
            alert.addAction(noAction)
            
            present(alert, animated: true, completion: nil)

    
        }
    }
    
    
}

//MARK: - Contact List Screen Delegate

extension ContactsListScreenVC: ContactListScreenDelegate {
    
    func update(contact: ContactModel) {
        contacts.append(contact)
        let indexPath = IndexPath(row: contacts.count - 1, section: 0)
        tableView.beginUpdates()
        tableView.insertRows(at: [indexPath], with: .automatic)
        tableView.endUpdates()

    }

}
