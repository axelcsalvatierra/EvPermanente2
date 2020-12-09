//
//  SiguiendoViewController.swift
//  EvPermanente2
//
//  Created by Axel Salvatierra on 12/7/20.
//

import UIKit

class SiguiendoViewController: UIViewController {
    
    var arraySiguiendo = [Siguiendo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.arraySiguiendo.append(Siguiendo(username: "Alejandra Lopez", profileImage: UIImage (named: "alejandra")!))
        
        self.arraySiguiendo.append(Siguiendo(username: "Jose Colmenares", profileImage: UIImage (named: "jose")!))
        
        self.arraySiguiendo.append(Siguiendo(username: "Luisa Quevedo", profileImage: UIImage (named: "luisa")!))
        
        self.arraySiguiendo.append(Siguiendo(username: "Paola Ricardini", profileImage: UIImage (named: "paola")!))
        
        self.arraySiguiendo.append(Siguiendo(username: "Raul Maradona", profileImage: UIImage (named: "raul")!))
        
    }
}

extension SiguiendoViewController: UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.arraySiguiendo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "SiguiendoViewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! SiguiendoViewCell
        
        cell.objPost = self.arraySiguiendo[indexPath.row]
        
        return cell
    }
    
}
