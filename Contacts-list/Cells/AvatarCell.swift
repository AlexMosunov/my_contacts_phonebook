//
//  AvatarCell.swift
//  Contacts-list
//
//  Created by Alex Mosunov on 3/20/20.
//  Copyright © 2020 Alex Mosunov. All rights reserved.
//

import UIKit

class AvatarCell: UICollectionViewCell {
    
    @IBOutlet weak var avatarImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
       
        
        let grayView = UIView(frame: bounds)
        grayView.backgroundColor = .gray
        self.selectedBackgroundView = grayView
    }
}
