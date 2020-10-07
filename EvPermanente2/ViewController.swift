//
//  ViewController.swift
//  EvPermanente2
//
//  Created by Axel Salvatierra on 10/6/20.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var constraintBottomScroll: NSLayoutConstraint!
    
    
    @IBAction func clickClosekeyboard(_ sender: Any) {
        print("CERRAR TECLADO ACCION")
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
        
        print("EL TECLADO APARECE")
        
        let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect ?? .zero
        let animationDuration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double ?? 0
        
        print(keyboardFrame)
        print(animationDuration)
        
    }
    
    @objc func keyboardWillHide(_ notification: Notification){
        
        print("EL TECLADO SE OCULTA")
        
    }


}

