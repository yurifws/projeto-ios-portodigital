//
//  RegistroViewController.swift
//  qualitapizzaria
//
//  Created by Yuri Fernando Wanderley Silva on 19/05/18.
//  Copyright © 2018 Yuri Fernando Wanderley Silva. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class RegistroViewController: UIViewController {
    
    let ref: DatabaseReference! = Database.database().reference()
    
    @IBOutlet weak var txtLogin: UITextField!
    @IBOutlet weak var txtSenha: UITextField!
    @IBOutlet weak var txtConfirmarSenha: UITextField!
    @IBOutlet weak var txtEndereco: UITextField!
    @IBOutlet weak var txtTelefone: UITextField!
    
    @IBAction func btnRegistrar(_ sender: Any) {
        let login = txtLogin.text!
        let senha = txtSenha.text!
        let confirmarSenha = txtConfirmarSenha.text!
        let endereco = txtEndereco.text!
        let telefone = txtTelefone.text!
        
        if(login != "" &&  senha != "" && confirmarSenha != "" && endereco != "" && telefone != ""){
            if(senha == confirmarSenha){
                Auth.auth().createUser(withEmail: login, password: senha) { (user, error) in
                    
                    if let error = error {
                        self.showToast(message: "Cadastro inválido ou já existente!")
                        return
                    }
                    if let user = user {
                        var userID = user.user.uid.description
                        
                        self.ref.child("usuarios").child(userID).setValue(["login": login,
                                                                             "endereco": endereco,
                                                                             "telefone": telefone])
                        
                        self.showToast(message: "Cadastro efetuado com sucesso!")
                        let loginTela = self.storyboard?.instantiateViewController(withIdentifier: "loginTela")
                        self.navigationController?.pushViewController(loginTela!, animated: true)
                    }
                }
            }else{
                self.showToast(message: "Senha de confirmacao diferente!")
            }
        }else{
            self.showToast(message: "Todos os campos são obrigatórios!")
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}


