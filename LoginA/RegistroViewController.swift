//
//  RegistroViewController.swift
//  LoginA
//
//  Created by Gerson Isaias on 12/01/21.
//

import UIKit

class RegistroViewController: UIViewController {

    @IBOutlet weak var tfUser: UITextField!
    @IBOutlet weak var tfPwd: UITextField!
    @IBOutlet weak var tfEmail: UITextField!
    
    let defaults = UserDefaults.standard
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func crearCuentaAction(_ sender: Any) {
        let userTxt = tfUser.text!
        if(userTxt.count > 0 && tfPwd.text?.count ?? 0 > 0 && tfEmail.text?.count ?? 0 > 0){
            let user = User(userTxt,tfPwd.text!,email:tfEmail.text!)
            
            if existUser(username: tfUser.text!) {
                let alert = UIAlertController(title:  "Usuario no disponible", message: "Este usaurio ya esta en uso", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
                    alert.dismiss(animated: true, completion: nil)
                }))
                self.present(alert, animated: true, completion: nil)
            }else{
                var usersStored = self.getUsers() // obtenemos usuario [User]?
                usersStored?.append(user) // si existe agregamos el nuevo usario
                let users:[User] = usersStored?.count ?? 0 > 0 ? usersStored! : [user] // asignamos un nuevo array o solo el que ya existia pero modificado
                
                do{
                    
                    print("Usuarios: \(users)")
                    let jsonEncoder = JSONEncoder()
                
                    let data = try jsonEncoder.encode(users)
                    
                    defaults.set(data,forKey: "users")
                    defaults.synchronize()
                    print("Usuario registrado")
                    let alert = UIAlertController(title:  "Usuario registrado", message: "El usuario ha sido registrado con exito", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
                            self.dismiss(animated: true, completion: nil)
                    }))
                    self.present(alert, animated: true, completion: nil)
                }catch{
                    print("Error al hacer el encode")
                }
            }
            
            
        }
    }
    
    
    func existUser(username:String) -> Bool{
        return getUsers()?.filter({ $0.username == username  }).count ?? 0  > 0 ? true : false
    }
    
    func getUsers() -> [User]?{
        do {
            let decoder = JSONDecoder()
            if let data = defaults.object(forKey: "users")  as? Data{
                return  try decoder.decode([User].self, from: data)
            }
        }catch{
            print("RegistroViewController.getUser.error:: No fue posible hacer la decodificacion")
        }
        return nil
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
