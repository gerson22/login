//
//  ViewController.swift
//  LoginA
//
//  Created by Gerson Isaias on 12/01/21.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var tfUser: UITextField!
    @IBOutlet weak var tfPwd: UITextField!
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tfUser.delegate = self
        tfPwd.delegate = self
        /*
         y : aplique delegado de x
         x = inactive -> notifica -> y -> realiza una accion
         
         */
        
        // Do any additional setup after loading the view.
    }

    @IBAction func auth(_ sender: Any) {
        let usertxt = tfUser.text!
        let pwdTxt = tfPwd.text!
        
        if usertxt.isEmpty || pwdTxt.isEmpty{
            let alertEmptyString = UIAlertController(title: "Datos incorrectos", message: "Los campos no han sido llenados correctamente", preferredStyle: .alert)
            alertEmptyString.addAction(UIAlertAction(title: "OK", style: .default, handler: { (alertAction) in
                alertEmptyString.dismiss(animated: true, completion: nil)
            }))
            self.present(alertEmptyString, animated: true, completion: nil)
        }
        if let data = defaults.object(forKey: "users")  as? Data{
            do{
                let decoder = JSONDecoder()
                let users = try decoder.decode([User].self, from:data)
                var logged = false
                /*users.forEach { (user) in
                    if user.username == usertxt && user.pwd == pwdTxt {
                        logged = true
                        user.saludar()
                        user.updateToken()
                    }
                }*/
                
                let newCollection = users.filter({$0.username == usertxt && $0.pwd == pwdTxt})
                logged = newCollection.count > 0 ? true : false
                if logged {
                    print("Logged")
                    newCollection.first?.saludar()
                    newCollection.first?.updateToken()
                }else{
                    print("Usuario no encontrado")
                    let alertEmptyString = UIAlertController(title: "Usuario no encontrado", message: "No existe algun usuario con estas credenciales, registrate por favor", preferredStyle: .alert)
                    alertEmptyString.addAction(UIAlertAction(title: "OK", style: .default, handler: { (alertAction) in
                        alertEmptyString.dismiss(animated: true, completion: nil)
                    }))
                    self.present(alertEmptyString, animated: true, completion: nil)
                }
            }catch{
                print("No fue posible decodificar")
            }
        }else{
            print("El object no es de tipo data")
        }
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.2) {
            self.view.transform = CGAffineTransform(translationX: 0, y: -100)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.2) {
            self.view.transform = .identity
        }
    }
    @IBAction func hideKeyboard(_ sender: UIButton) {
        self.view.endEditing(true)
        //self.resignFirstResponder()
    }
}

