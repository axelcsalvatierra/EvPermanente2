//
//  PerfilViewController.swift
//  EvPermanente2
//
//  Created by Axel Salvatierra on 12/9/20.
//

import UIKit

class PerfilViewController: UIViewController, UIPickerViewDelegate ,UIPickerViewDataSource{
    
    var isActive: Bool = false
    
    @IBOutlet var imgPerfil: UIImageView!
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtSede: UITextField!
    @IBOutlet weak var txtCarreras: UITextField!
    @IBOutlet weak var validacionMensaje: UILabel!
    @IBOutlet weak var fechaNacimiento: UITextField!
    @IBOutlet weak var btnUsername: UIButton!
    @IBOutlet weak var btnCarrera: UIButton!
    @IBOutlet weak var btnSede: UIButton!
    @IBOutlet weak var btnFecha: UIButton!
    
    
    
    @IBAction func didTapButton() {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
        
    }
    
    
    
    
    let sedes = ["Miraflores", "Jesus María", "San Isidro", "La Molina"]
    
    var pickerView = UIPickerView()
    
    var datePicker: UIDatePicker!
    
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
    

    
    @IBAction func btnEditarUsername(_ sender: Any) {
        
        if isActive {
            
            txtUsername.isUserInteractionEnabled = true
            isActive=false
            btnUsername.setImage(UIImage(named: "guardar"), for: .normal)
        }else {
            
            txtUsername.isUserInteractionEnabled = false
            isActive = true
            btnUsername.setImage(UIImage(named: "editar"), for: .normal)
        }
        
        
    }
    
    @IBAction func btnEditarCarrera(_ sender: Any) {
        
        if isActive {
            
            txtCarreras.isUserInteractionEnabled = true
            isActive=false
            btnCarrera.setImage(UIImage(named: "guardar"), for: .normal)
        }else {
            
            txtCarreras.isUserInteractionEnabled = false
            isActive = true
            btnCarrera.setImage(UIImage(named: "editar"), for: .normal)
        }
    }
    
    
    @IBAction func btnEditarSede(_ sender: Any) {
        
        if isActive {
            
            txtSede.isUserInteractionEnabled = true
            isActive=false
            btnSede.setImage(UIImage(named: "guardar"), for: .normal)
        }else {
            
            txtSede.isUserInteractionEnabled = false
            isActive = true
            btnSede.setImage(UIImage(named: "editar"), for: .normal)
        }
    }
    
    @IBAction func btnEditarFecha(_ sender: Any) {
        
        if isActive {
            
            fechaNacimiento.isUserInteractionEnabled = true
            isActive=false
            btnFecha.setImage(UIImage(named: "guardar"), for: .normal)
        }else {
            
            fechaNacimiento.isUserInteractionEnabled = false
            isActive = true
            btnFecha.setImage(UIImage(named: "editar"), for: .normal)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpDatePicker()
        pickerView.delegate = self
        pickerView.dataSource = self
        
        txtSede.inputView = pickerView
        txtSede.textAlignment = .left
        
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


extension PerfilViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {
            imgPerfil.image=image
            
        }
        picker.dismiss(animated: true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    
}
