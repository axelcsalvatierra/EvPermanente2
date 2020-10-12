//
//  RegistrarUsuarioViewController.swift
//  EvPermanente2
//
//  Created by Axel Salvatierra on 10/11/20.
//

import UIKit

class RegistrarUsuarioViewController: UIViewController {

    
    @IBOutlet weak var txtEmail: UITextField!
    
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtNombre: UITextField!
    @IBOutlet weak var txtApellido: UITextField!
    @IBOutlet weak var validacionMensaje: UILabel!
    
    
    
    @IBAction func btnCrearCuenta(_ sender: Any) {
        
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
                    validacionMensaje.text = "Crea una contraseña"
                    return
                }
        
        guard let nombre = txtNombre.text, txtNombre.text?.count != 0 else {
                    validacionMensaje.isHidden = false
                    validacionMensaje.text = "Ingresa tu nombre"
                    return
                }
        
        guard let apellido = txtApellido.text, txtApellido.text?.count != 0  else {
                    validacionMensaje.isHidden = false
                    validacionMensaje.text = "Ingresa tu apellido"
                    return
                }
        
        /*func isValidNombre() {
            
            var validacion = validacionMensaje
            let nombre = txtNombre
            if (nombre?.text?.count ?? 0 >= 15){
                validacion = ""
                
            }*/
            
    }
    
    func isValidEmail(emailID:String) -> Bool {
            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
            let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
            return emailTest.evaluate(with: emailID)
        }
    
    
    
    
    
    
    //ANIMACION DE PANTALLA Y TECLADO
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
            
            self.constraintBottomScroll.constant = keyboardFrame.size.height
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
