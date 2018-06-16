//
//  ViewController.swift
//  qualitapizzaria
//
//  Created by Yuri Fernando Wanderley Silva on 19/05/18.
//  Copyright © 2018 Yuri Fernando Wanderley Silva. All rights reserved.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {

    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtSenha: UITextField!
    
    
    
    @IBAction func btnLogin(_ sender: Any) {
        let email = txtEmail.text!
        let senha = txtSenha.text!
        if(email != "" && senha != ""){
            Auth.auth().signIn(withEmail: email, password: senha){ (user, error) in
                    if let error = error {
                        self.showToast(message: "Login incorreto ou inválido!")
                        return
                    }
                self.showToast(message: "Login efetuado com sucesso!")
                let pedidosTela = self.storyboard?.instantiateViewController(withIdentifier: "tabBar")
                self.navigationController?.pushViewController(pedidosTela!, animated: true)
                
            }
        }else{
            self.showToast(message: "Campos obrigatórios para login!")
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

extension UIViewController {
    
    func showToast(message : String) {
        
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: 300, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.font = UIFont(name: "Montserrat-Light", size: 12.0)
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    } }

