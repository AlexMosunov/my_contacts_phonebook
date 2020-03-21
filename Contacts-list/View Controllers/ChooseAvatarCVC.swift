//
//  ChooseAvatarCVC.swift
//  Contacts-list
//
//  Created by Alex Mosunov on 3/20/20.
//  Copyright © 2020 Alex Mosunov. All rights reserved.
//

import UIKit

private let reuseIdentifier = "AvatarCell"

class ChooseAvatarCVC: UICollectionViewController {
    
    var contact: ContactModel?
 
    
    @IBOutlet var myCollectionView: UICollectionView!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    var avatarImageName = ""

    let avatarImageNames = ["avatar1", "avatar2", "avatar3",
                            "avatar4", "avatar5", "avatar6",
                            "avatar7", "avatar8", "avatar9",
                            "avatar10", "avatar11", "avatar12",
                            "avatar13", "avatar14", "avatar15",
                            "avatar16", "avatar17", "avatar18", "avatar19"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        doneButton.isEnabled = false
        
    }



    // MARK: UICollectionViewDataSource


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return avatarImageNames.count
        
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! AvatarCell
    
        cell.avatarImageView.image = UIImage(named: avatarImageNames[indexPath.row])
    
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        avatarImageName = avatarImageNames[indexPath.row]
        doneButton.isEnabled = true
        
    }
    
    
    @IBAction func doneTapped(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
    
    


}
