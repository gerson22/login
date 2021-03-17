//
//  User.swift
//  LoginA
//
//  Created by Gerson Isaias on 12/01/21.
//

import UIKit

struct User : Codable{
    var username: String
    var pwd: String
    var email: String
    
    init(_ username:String, _ pwd:String, email:String){
        self.username = username
        self.pwd = pwd
        self.email = email
    }
    
    func saludar(){
        print("Hola, mi nombre es: \(self.username) y mi correo es: \(self.email)")
    }
    
    func updateToken(){
        print("Actualizando token")
    }
}
