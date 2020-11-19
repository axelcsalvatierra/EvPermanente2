//
//  RestablecerContrasenaViewController.swift
//  EvPermanente2
//
//  Created by Axel Salvatierra on 10/11/20.
//

import UIKit
import Firebase

class RestablecerContrasenaViewController: UIViewController {

    
    //VARIABLES DE RANDOM CAPTCHA
    var alphas : [String] = []
    var captchaString = ""
    var i1 : Int = 0
    var i2 : Int = 0
    var i3 : Int = 0
    var i4 : Int = 0
    var i5 : Int = 0
    
    @IBOutlet weak var captchaLabel: UILabel!
    @IBOutlet weak var captchaText: UITextField!
    @IBOutlet weak var estadoLabel: UILabel!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var validacionMensaje: UILabel!
    
    
    override func viewDidLoad() {
        
        //GENERAR RANDOM CAPTCHA
        alphas = [ "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "a", "b", "c", "d", "e", "f", "g", "h", "i", "j",
                   "k", "l", "m", "n", "ñ", "o", "p", "q", "r", "s","t", "u", "v", "w", "x", "y", "z", "A", "B", "C",
                   "D", "E", "F", "G", "H", "I", "J", "K", "L", "M","N", "ñ", "O", "P", "Q", "R", "S", "T", "U", "V",
                   "W", "X", "Y", "Z"]
        
        
        //LIMPIAR LABEL
        txtEmail.clearButtonMode = .always
        txtEmail.clearButtonMode = .whileEditing
        captchaText.clearButtonMode = .always
        captchaText.clearButtonMode = .whileEditing
        
        
        self.updateBorderSelect(false, toTextField: self.txtEmail)
        self.updateBorderSelect(false, toTextField: self.captchaText)
    }
    
    //CAMBIAR COLOR DE BORDES DE TEXTFIELD
    
    func updateBorderSelect(_ isSelect: Bool, toTextField textField: UITextField) {
        textField.layer.borderWidth = 1
        textField.layer.borderColor = isSelect ? UIColor(displayP3Red: 0.5, green: 0.7, blue: 1, alpha: 1).cgColor : UIColor.lightGray.cgColor
    }
    
    
    
    
    //HACER FUNCIONAR EL CAPTCHA CORRECTO O INCORRECTO CON EL EMAIL
    func actualizarCaptcha(){
        i1 = Int(arc4random()) % alphas.count
        i2 = Int(arc4random()) % alphas.count
        i3 = Int(arc4random()) % alphas.count
        i4 = Int(arc4random()) % alphas.count
        i5 = Int(arc4random()) % alphas.count
        
        captchaString = "\(alphas[i1])\(alphas[i2])\(alphas[i3])\(alphas[i4])\(alphas[i5])"
        print(captchaString)
        captchaLabel.text=captchaString
        
    }
    
    @IBAction func actualizarBoton(_ sender: UIButton) {
        actualizarCaptcha()
    }
    
    @IBAction func btnRestablecer(_ sender: Any) {
        
        let error = validacionLabels()
        
        if error != nil {
            
            mostrarError(error!)
        }else {
            
            let email=txtEmail.text!
            
            //RECUPERAR CONTRASEñA
            Auth.auth().sendPasswordReset(withEmail: email) { (error) in
                if error != nil {
                    
                    self.validacionMensaje.text = "Ingresa un email válido"
                }else {
                    self.validacionMensaje.isHidden=true
                    self.inputCorrectos()
                }
                
            }
        }
        
        
    }
    
    func mostrarError(_ mensaje:String){
        
        validacionMensaje.text = mensaje
        
    }
    
    func validacionLabels()->String? {
        
        if captchaLabel.text == captchaText.text{
            estadoLabel.text = "Captcha Correcto"
            estadoLabel.textColor = .green
        }else{
            estadoLabel.text = "El captcha es incorrecto"
            estadoLabel.textColor = .red
            
        }
        
        //validacionMensaje.isHidden = true
        
        guard let email = txtEmail.text, txtEmail.text?.count != 0  else {
                    
                    return "Ingresa tu email"
                }
        
        if isValidEmail(emailID: email) == false{
        
                    return "Por favor ingresa un email válido"
                }
        
        
        
        return nil
    }
    
    
    func inputCorrectos() {
        if (validacionMensaje.isHidden==true && captchaLabel.text == captchaText.text ){
            showAlert()
        }
    }
    
    
    func isValidEmail(emailID:String) -> Bool {
            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
            let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
            return emailTest.evaluate(with: emailID)
        }
    
    func showAlert(){
        let alert = UIAlertController(title: "Link Enviado", message: "Revisa tu bandeja de entrada para cambiar tu contraseña", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Cerrar", style: .cancel, handler: { action in
            
        }))
        
        present(alert, animated: true)
    
    }
    
    
    
    
    //COMPORTAMIENTO DEL TECLADO Y ANIMACION
    @IBOutlet weak var constraintCenterYContent: NSLayoutConstraint!
    
    @IBOutlet weak var viewContent: UIView!
    
    @IBAction func clickClosekeyboard(_ sender: Any) {
        self.view.endEditing(true)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        actualizarCaptcha()
        
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
            delta = originkeyboardY - finalPosyContent
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

extension RestablecerContrasenaViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        self.updateBorderSelect(true, toTextField: textField)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        self.updateBorderSelect(false, toTextField: textField)
        
    }
    
}
