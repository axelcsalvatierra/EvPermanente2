//
//  RegistrarUsuarioViewController.swift
//  EvPermanente2
//
//  Created by Axel Salvatierra on 10/11/20.
//

import UIKit
import FirebaseAuth
import Firebase

class RegistrarUsuarioViewController: UIViewController, UIPickerViewDelegate ,UIPickerViewDataSource {

    
    @IBOutlet weak var txtEmail: UITextField!
    
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtNombre: UITextField!
    @IBOutlet weak var txtApellido: UITextField!
    @IBOutlet weak var txtSede: UITextField!
    @IBOutlet weak var txtCarreras: UITextField!
    @IBOutlet weak var validacionMensaje: UILabel!
    @IBOutlet weak var fechaNacimiento: UITextField!
    
    
    /*let carreras = ["Área de Tecnología", "Área de Comunicación", "Área de Marketing", "Área de Negocios", "Área de Hotelería y Turismo"]*/
    
    let sedes = ["Miraflores", "Jesus María", "San Isidro", "La Molina"]
    
    var pickerView = UIPickerView()
    
    var datePicker: UIDatePicker!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //CAMBIAR COLOR DE BORDES DE TEXTFIELD
        self.updateBorderSelect(false, toTextField: self.txtEmail)
        self.updateBorderSelect(false, toTextField: self.txtNombre)
        self.updateBorderSelect(false, toTextField: self.txtApellido)
        self.updateBorderSelect(false, toTextField: self.txtSede)
        self.updateBorderSelect(false, toTextField: self.txtPassword)
        self.updateBorderSelect(false, toTextField: self.txtCarreras)
        self.updateBorderSelect(false, toTextField: self.fechaNacimiento)
        
        
        txtNombre.delegate = self
        txtApellido.delegate = self
        txtCarreras.delegate = self
        txtSede.delegate = self
        fechaNacimiento.delegate = self
        
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        txtSede.inputView = pickerView
        txtSede.textAlignment = .left
        
        setUpDatePicker()
        
        
        //LIMPIAR LABEL
        txtEmail.clearButtonMode = .always
        txtEmail.clearButtonMode = .whileEditing
        
        txtPassword.clearButtonMode = .always
        txtPassword.clearButtonMode = .whileEditing
        
        txtNombre.clearButtonMode = .always
        txtNombre.clearButtonMode = .whileEditing
        
        txtApellido.clearButtonMode = .always
        txtApellido.clearButtonMode = .whileEditing
        
        txtSede.clearButtonMode = .always
        txtSede.clearButtonMode = .whileEditing
        
        txtCarreras.clearButtonMode = .always
        txtCarreras.clearButtonMode = .whileEditing
        
        
    }
    
    //CAMBIAR COLOR DE BORDES DE TEXTFIELD
    
    func updateBorderSelect(_ isSelect: Bool, toTextField textField: UITextField) {
        textField.layer.borderWidth = 1
        textField.layer.borderColor = isSelect ? UIColor(displayP3Red: 0.5, green: 0.7, blue: 1, alpha: 1).cgColor : UIColor.lightGray.cgColor
    }
    
    
    //INPUT DE SEDES
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return sedes.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return sedes[row]
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        txtSede.text = sedes[row]
        txtSede.resignFirstResponder()
        

    }
    

    //CALENDARIO
    func setUpDatePicker () {
        
        self.datePicker = UIDatePicker.init(frame: CGRect (x: 0, y: 0, width: self.view.bounds.width, height: 200))
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(self.dateChanged), for: .allEvents)
        
        if #available(iOS 14, *) {
            datePicker.preferredDatePickerStyle = .wheels
        }
        
        self.fechaNacimiento.inputView = datePicker
        
        let toolBar:UIToolbar = UIToolbar.init(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 44))
        
        let spaceButton: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        
        let doneButton:UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(self.tapOnDoneButton))
        
        
        toolBar.setItems([spaceButton, doneButton], animated: true)
        
        self.fechaNacimiento.inputAccessoryView = toolBar
        
    }
    
    @objc func dateChanged() {
        
        let formatoFecha = DateFormatter()
        formatoFecha.dateStyle = .medium
        formatoFecha.locale = Locale (identifier: "es_PE")
        
        self.fechaNacimiento.text = formatoFecha.string(from: datePicker.date)
        
    }
    
    @objc func tapOnDoneButton(){
        
        fechaNacimiento.resignFirstResponder()
        
    }
    
    
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
                let caracteresPermitidos = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz "
                let caracterPermitidoSet = CharacterSet(charactersIn: caracteresPermitidos)
                let typedCharcterSet = CharacterSet(charactersIn: string)
                return caracterPermitidoSet.isSuperset(of: typedCharcterSet)
    }
    //"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
    
    
    @IBAction func btnCrearCuenta(_ sender: Any) {
        
        let error = validacionLabels()
        
        if error != nil {
            mostrarError(error!)
            
        }else {
            
            let email = txtEmail.text!
            let password = txtPassword.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let nombre = txtNombre.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let apellido = txtApellido.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let sede = txtSede.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let carreras = txtCarreras.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let nacimiento = fechaNacimiento.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            //CREAR EL USUARIO
            Auth.auth().createUser(withEmail: email, password: password) { result, error in
                    if error != nil {
                        
                        self.mostrarError("Error al crear usuario")
                        
                    }else {
                        let db = Firestore.firestore()
                        
                        db.collection("alumnos").addDocument(data: ["nombre": nombre, "apellido": apellido, "sede": sede, "carrera": carreras, "nacimiento": nacimiento, "uid": result!.user.uid]) { (error) in
                            
                            if error != nil {
                                
                                self.mostrarError("Error cargando datos de usuario")
                            }
                        }
                        
                        self.validacionMensaje.textColor = .green
                        self.validacionMensaje.text = "CREACIÓN DE CUENTA EXITOSA, BIENVENIDO :D"
                        
                        
                    }
                        self.borrarLabels()
                }
        }
                        
}
    
    func borrarLabels(){
        
        txtEmail.text=nil
        txtPassword.text=nil
        txtNombre.text=nil
        txtApellido.text=nil
        txtSede.text=nil
        txtCarreras.text=nil
        fechaNacimiento.text=nil
    }
    
    func mostrarError(_ mensaje:String){
        
        validacionMensaje.text = mensaje
        
    }
    
    func validacionLabels() -> String?{
        
        //validacionMensaje.isHidden = true
        
        guard let email = txtEmail.text, txtEmail.text?.count != 0  else {
                    //validacionMensaje.isHidden = false
                    //validacionMensaje.text = "Ingresa tu email"
                    return "Ingresa tu email"
                }
        
        if isValidEmail(emailID: email) == false {

                    return "Por favor ingresa un email válido"
                }
        
        guard let password = txtPassword.text, txtPassword.text?.count != 0  else {

                    return "Crea una contraseña"
                }
        
        if isValidPassword(passwordID: password) == false {
            
            return "Verifica que tu contraseña contenga un carácter especial, un número y almenos 5 caracteres"
        }
        
        guard let _ = txtNombre.text, txtNombre.text?.count != 0 else {
            
                    return "Ingresa tu nombre"
                }
        
        
        guard let _ = txtApellido.text, txtApellido.text?.count != 0  else {

                    return "Ingresa tu apellido"
                }
        
        guard let _ = txtSede.text, txtSede.text?.count != 0  else {

                    return "Ingresa tu sede"
                }
        
        guard let _ = txtCarreras.text, txtCarreras.text?.count != 0  else {

                    return "Ingresa tu carrera"
                }
        
        guard let _ = fechaNacimiento.text, fechaNacimiento.text?.count != 0  else {

                    return "Ingresa tu fecha de nacimiento"
            
                }
        return nil
        
    }
    
    /*func inputCorrectos (){
        if (validacionMensaje.isHidden == true){
            validacionMensaje.isHidden = false
            validacionMensaje.textColor = .green
            validacionMensaje.text = "CREACIÓN DE CUENTA EXITOSA, BIENVENIDO :D"
        }
        
    }*/
    
    func isValidEmail(emailID:String) -> Bool {
            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
            let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
            return emailTest.evaluate(with: emailID)
        }
    
    func isValidPassword(passwordID:String) -> Bool {
        let password = NSPredicate(format: "SELF MATCHES %@ ", "^(?=.*[a-z])(?=.*[$@$#!%*?&]).{5,}$")
        return password.evaluate(with: passwordID)
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

extension RegistrarUsuarioViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        self.updateBorderSelect(true, toTextField: textField)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        self.updateBorderSelect(false, toTextField: textField)
        
    }
}
