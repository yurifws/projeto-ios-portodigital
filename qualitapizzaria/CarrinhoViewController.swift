//
//  CarrinhoViewController.swift
//  qualitapizzaria
//
//  Created by Yuri Fernando Wanderley Silva on 19/05/18.
//  Copyright © 2018 Yuri Fernando Wanderley Silva. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class CarrinhoViewController: UIViewController {
     let ref: DatabaseReference! = Database.database().reference()
     let array: [String] = ["mussarela", "calabresa", "moda da casa"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func mussarela(_ sender: Any) {
        self.fazerPedido(pizza: array[0])
    }
    
    @IBAction func calabresa(_ sender: Any) {
        self.fazerPedido(pizza: array[1])
    }
    
    @IBAction func modaCasa(_ sender: Any) {
        self.fazerPedido(pizza: array[2])
    }
    
    
    func fazerPedido(pizza: String){
        let uid = Auth.auth().currentUser?.uid.description
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy - HH:mm:ss"
        let result = formatter.string(from: date)
        
        ref.child("pedidos").child(uid!).childByAutoId().setValue(["pizza": pizza,
                                                    "data": result])
        self.showToast(message: "Pedido efetuado com sucesso!")
    }
    
    
}
