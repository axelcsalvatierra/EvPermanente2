//
//  PublicacionesViewController.swift
//  EvPermanente2
//
//  Created by Axel Salvatierra on 12/2/20.
//

import UIKit

class PublicacionesViewController: UIViewController {
    
    var arrayPublicaciones = [Publicaciones]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.arrayPublicaciones.append(Publicaciones(username: "Axel Salvatierra", profileImage: UIImage(named: "Logocortado")!, fecha: "02/12/2020", descripcion: "Aquí les dejo el calendario del ciclo 2020-2", postImage: UIImage(named: "1")!))
        
        self.arrayPublicaciones.append(Publicaciones(username: "Alejandra Lopez", profileImage: UIImage(named: "alejandra")!, fecha: "28/11/2020", descripcion: "Espero que todos tengan éxitos este ciclo", postImage: UIImage(named: "2")!))
        
        self.arrayPublicaciones.append(Publicaciones(username: "Jose Colmenares", profileImage: UIImage(named: "jose")!, fecha: "20/11/2020", descripcion: "Los invitamos este 6 de diciembre a la pausa creativa que organizan los chicos de la comunidad", postImage: UIImage(named: "3")!))
        
        self.arrayPublicaciones.append(Publicaciones(username: "Luisa Quevedo", profileImage: UIImage(named: "luisa")!, fecha: "18/11/2020", descripcion: "Les presento mi proyecto navideño. Conozcan a Halia una marca con fin social", postImage: UIImage(named: "4")!))
        
    }
    
    @objc func btnLikeTapped(sender: UIButton){
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
                sender.transform = CGAffineTransform(scaleX: 1.6, y: 1.6)
                 sender.alpha = 5.0
            }) { finished in
                 sender.alpha = 5.0
                UIView.animate(withDuration: 0.3) {
                    sender.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                    
                    
                }
                
            }
        }
    }
}


extension PublicacionesViewController: UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.arrayPublicaciones.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "PostTableViewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! PostTableViewCell
        
        cell.objPost = self.arrayPublicaciones[indexPath.row]
        cell.btnLike.tag = indexPath.row
        cell.btnLike.addTarget(self, action: #selector(btnLikeTapped(sender:)), for: .touchUpInside)
        
        return cell
    }
    
}
