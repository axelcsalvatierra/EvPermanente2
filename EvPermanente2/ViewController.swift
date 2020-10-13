//
//  ViewController.swift
//  EvPermanente2
//
//  Created by Axel Salvatierra on 10/6/20.
//

import UIKit

class ViewController: UIViewController {
    
    
    
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var validacionMensaje: UILabel!
    
    
    @IBAction func btnIngresar(_ sender: Any) {
        
        validacionMensaje.isHidden = true
        
        guard let email = txtEmail.text, txtEmail.text?.count != 0  else {
                    validacionMensaje.isHidden = false
                    validacionMensaje.text = "Ingresa tu email"
                    return
                }
        
        if isValidEmail(emailID: email) == false {
                    validacionMensaje.isHidden = false
                    validacionMensaje.text = "Por favor ingresa un email válido"
                }
        
        guard let password = txtPassword.text, txtPassword.text?.count != 0  else {
                    validacionMensaje.isHidden = false
                    validacionMensaje.text = "Ingresa tu contraseña"
                    return
                }
        
        inputCorrectos()
    }
    
    func inputCorrectos (){
        if (validacionMensaje.isHidden == true){
            validacionMensaje.isHidden = false
            validacionMensaje.textColor = .green
            validacionMensaje.text = "LOGIN CON ÉXITO"
        }
        
    }
    
    func isValidEmail(emailID:String) -> Bool {
            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
            let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
            return emailTest.evaluate(with: emailID)
        }
    
    //ANIMACION DE PANTALLA Y TECLADO
    

    
    @IBOutlet weak var constraintCenterYContent: NSLayoutConstraint!
    
    @IBOutlet weak var viewContent: UIView!
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
        
        let finalPosyContent = self.viewContent.frame.origin.y + self.viewContent.frame.height
        let originkeyboardY = keyboardFrame.origin.y
        var delta: CGFloat = 0
        
        if originkeyboardY < finalPosyContent {
            delta = originkeyboardY - finalPosyContent - 130
        }

        UIView.animate(withDuration: animationDuration) {
            
            self.constraintCenterYContent.constant = delta
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification){
        
        let animationDuration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double ?? 0
        
        UIView.animate(withDuration: animationDuration) {
            
            self.constraintCenterYContent.constant = 0
            self.view.layoutIfNeeded()
        }
        
    }


}

