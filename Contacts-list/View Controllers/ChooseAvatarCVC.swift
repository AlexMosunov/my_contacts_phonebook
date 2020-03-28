//
//  ChooseAvatarCVC.swift
//  Contacts-list
//
//  Created by Alex Mosunov on 3/20/20.
//  Copyright © 2020 Alex Mosunov. All rights reserved.
//

import UIKit

private let reuseIdentifier = "AvatarCell"

protocol ChooseAvatarDelegate {
    func didChooseAvatar(avatar: UIImage)
}

class ChooseAvatarCVC: UICollectionViewController {
    
    var contact: ContactModel?
    
    var selectionDelegate: ChooseAvatarDelegate!
 
    
    @IBOutlet var myCollectionView: UICollectionView!
    
    
    var avatarImageName: UIImage?
    let avatarImage = AvatarImage()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    


    // MARK: UICollectionViewDataSource

    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return avatarImage.avatarImageNames.count
        
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! AvatarCell
    
        cell.avatarImageView.image = UIImage(named: avatarImage.avatarImageNames[indexPath.row])
    
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let chosenAvatarImage = UIImage(named: avatarImage.avatarImageNames[indexPath.row]) {
            selectionDelegate.didChooseAvatar(avatar: chosenAvatarImage)
        }
        
        navigationController?.popViewController(animated: true)
        
    }
    
}


