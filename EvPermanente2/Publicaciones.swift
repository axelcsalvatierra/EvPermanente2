//
//  Publicaciones.swift
//  EvPermanente2
//
//  Created by Axel Salvatierra on 12/2/20.
//
import UIKit
import Foundation

class Publicaciones {
    
    var username: String
    var profileImage: UIImage?
    var fecha: String
    var descripcion: String
    var postImage: UIImage?
    
    
    init(username: String, profileImage: UIImage, fecha: String, descripcion: String, postImage: UIImage) {
        self.username = username
        self.profileImage = profileImage
        self.fecha = fecha
        self.descripcion = descripcion
        self.postImage = postImage
    }
}



