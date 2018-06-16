//
//  AlterarDadosViewController.swift
//  qualitapizzaria
//
//  Created by Yuri Fernando Wanderley Silva on 19/05/18.
//  Copyright © 2018 Yuri Fernando Wanderley Silva. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class AlterarDadosViewControler: UIViewController {
    
    let uid = Auth.auth().currentUser?.uid.description
    var usuario = Usuario.init()
    let ref: DatabaseReference! = Database.database().reference()
    
    @IBOutlet weak var lblLogin: UILabel!
    @IBOutlet weak var txtEndereco: UITextField!
    @IBOutlet weak var txtTelefone: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buscarDadosUsuario()
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnAlterarDados(_ sender: UIButton) {
        var login = lblLogin.text
        var endereco = txtEndereco.text
        var telefone = txtTelefone.text
        
        if(endereco != "" && telefone != ""){
            usuario.endereco = endereco!
            usuario.telefone = telefone!
            
            ref.child("usuarios").child(uid!).setValue(["login": usuario.login,
                                                        "endereco": usuario.endereco,
                                                        "telefone": usuario.telefone])
        }else{
            self.showToast(message: "Todos os campos são obrigatórios!")
        }
    }
    
    
    func buscarDadosUsuario(){
        ref.child("usuarios").child(uid!).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            let login = value?["login"] as? String ?? ""
            let endereco = value?["endereco"] as? String ?? ""
            let telefone = value?["telefone"] as? String ?? ""
            self.usuario = Usuario.init(login: login, endereco: endereco, telefone: telefone)
            
            self.lblLogin.text = self.usuario.login
            self.txtEndereco.text = self.usuario.endereco
            self.txtTelefone.text = self.usuario.telefone
            // ...
        }) { (error) in
            print(error.localizedDescription)
        }

    }
    
    
    
}
