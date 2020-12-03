//
//  PostTableViewCell.swift
//  EvPermanente2
//
//  Created by Axel Salvatierra on 12/2/20.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var fechaLabel: UILabel!
    @IBOutlet weak var descripcionLabel: UILabel!
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var btnLike: UIButton!
    @IBOutlet weak var btnComment: UIButton!
    
    
    var objPost: Publicaciones! {
        
        didSet {
            self.updateData()
        }
    }
    
    private func updateData() {
        
        self.usernameLabel.text = self.objPost.username
        self.profileImageView.image = self.objPost.profileImage
        self.fechaLabel.text = self.objPost.fecha
        self.descripcionLabel.text = self.objPost.descripcion
        self.postImageView.image = self.objPost.postImage
        
    }
}
