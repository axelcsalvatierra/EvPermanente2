//
//  SiguiendoViewCell.swift
//  EvPermanente2
//
//  Created by Axel Salvatierra on 12/7/20.
//

import UIKit

class SiguiendoViewCell: UITableViewCell {
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var btnNoSeguir: UIButton!
    
    
    var objPost: Siguiendo! {
        
        didSet {
            self.updateData()
        }
    }
    
    private func updateData() {
        
        self.usernameLabel.text = self.objPost.username
        self.profileImageView.image = self.objPost.profileImage
        self.profileImageView.layer.cornerRadius = profileImageView.frame.size.width / 2
        self.profileImageView.clipsToBounds = true
        
        
    }
}

