//
//  misPublicacionesViewController.swift
//  EvPermanente2
//
//  Created by Axel Salvatierra on 12/10/20.
//

import UIKit

class misPublicacionesViewController: UIViewController,UITableViewDelegate {
    
    
    @IBOutlet weak var tblPost:UITableView!
    
    
    var arraymisPublicaciones = [misPublicaciones]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblPost.dataSource = self
        tblPost.delegate = self
    
        self.arraymisPublicaciones.append(misPublicaciones(username: "Axel Salvatierra", profileImage: UIImage(named: "Logocortado")!, fecha: "02/12/2020", descripcion: "Aquí les dejo el calendario del ciclo 2020-2", postImage: UIImage(named: "1")!))
        
        self.arraymisPublicaciones.append(misPublicaciones(username: "Axel Salvatierra", profileImage: UIImage(named: "Logocortado")!, fecha: "28/11/2020", descripcion: "Se regala syllabus + Adobe CC", postImage: UIImage(named: "5")!))
        
        self.arraymisPublicaciones.append(misPublicaciones(username: "Axel Salvatierra", profileImage: UIImage(named: "Logocortado")!, fecha: "20/11/2020", descripcion: "Espero que todos tengan éxitos este ciclo", postImage: UIImage(named: "2")!))
        
        self.arraymisPublicaciones.append(misPublicaciones(username: "Axel Salvatierra", profileImage: UIImage(named: "Logocortado")!, fecha: "18/11/2020", descripcion: "Si alguien desea colaborar su donación sera utilizada en compra masiva de artículos de higiene personal, artículos de bioseguridad y algo para su noche buena", postImage: UIImage(named: "6")!))
        
        
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


extension misPublicacionesViewController: UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.arraymisPublicaciones.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "misPublicacionesViewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! misPublicacionesViewCell
        
        cell.objPost = self.arraymisPublicaciones[indexPath.row]
        cell.btnLike.tag = indexPath.row
        cell.btnLike.addTarget(self, action: #selector(btnLikeTapped(sender:)), for: .touchUpInside)
        
        cell.btnBorrar.addTarget(self, action: #selector(deleteRow(_ :)), for: .touchUpInside)
        
        return cell
    }
    
    
    @objc func deleteRow(_ sender: UIButton) {
        
        func alertaBorrar(title: String, mensaje: String) {
            
            
            let alert = UIAlertController(title: "Eliminar Publicación", message: "Estas seguro que desea eliminar", preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction.init(title: "Si", style: UIAlertAction.Style.default, handler: {(action) in
                
                let point = sender.convert(CGPoint.zero, to: self.tblPost)
                guard let indexPath = self.tblPost.indexPathForRow(at: point) else {
                    return
                }
                self.arraymisPublicaciones.remove(at: indexPath.row)
                self.tblPost.deleteRows(at: [indexPath], with: .left)
            }))
            
            alert.addAction(UIAlertAction.init(title: "No", style: UIAlertAction.Style.default, handler: {(action) in
                
                alert.dismiss(animated: true, completion: nil)
            }))
            self.present(alert, animated: true, completion: nil)
            
        }
        
        let point = sender.convert(CGPoint.zero, to: tblPost)
        guard let indexPath = tblPost.indexPathForRow(at: point) else {
            return
        }
        arraymisPublicaciones.remove(at: indexPath.row)
        tblPost.deleteRows(at: [indexPath], with: .left)
    }
    
}
