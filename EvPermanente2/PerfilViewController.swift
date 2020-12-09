//
//  PerfilViewController.swift
//  EvPermanente2
//
//  Created by Axel Salvatierra on 12/9/20.
//

import UIKit

class PerfilViewController: UIViewController {
    
    @IBOutlet var imgPerfil: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imgPerfil.layer.cornerRadius = imgPerfil.frame.size.width / 2
        imgPerfil.clipsToBounds = true
    }
    
    
    
    
    
    
    
    
    
    
    
    
    //COMPORTAMIENTO DE PANTALLA Y TECLADO
    
    @IBOutlet weak var constraintBottomScroll: NSLayoutConstraint!
    
    @IBAction func clickClosekeyboard(_ sender: Any) {
        self.view.endEditing(true)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(_:)), name: UIResponder.keyboardDidHideNotification, object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func keyboardWillShow(_ notification: Notification){
        
        let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect ?? .zero
        let animationDuration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double ?? 0

        UIView.animate(withDuration: animationDuration) {
            
            self.constraintBottomScroll.constant =
            keyboardFrame.size.height
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification){
        
        let animationDuration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double ?? 0
        
        UIView.animate(withDuration: animationDuration) {
            
            self.constraintBottomScroll.constant = 0
            self.view.layoutIfNeeded()
        }
        
    }
}
