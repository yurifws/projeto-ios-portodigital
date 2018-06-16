//
//  PedidosViewController.swift
//  qualitapizzaria
//
//  Created by Yuri Fernando Wanderley Silva on 19/05/18.
//  Copyright © 2018 Yuri Fernando Wanderley Silva. All rights reserved.
//
import UIKit
import FirebaseDatabase
import FirebaseAuth

class PedidosViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    let ref: DatabaseReference! = Database.database().reference()
    let cellId = "cellId"
    var refHandle: UInt!
    var pedidosList = [Pedido]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buscaPedidos()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.pedidosList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellId)
        var textoPedido: String = ""
        textoPedido.append(pedidosList[indexPath.row].pizza)
        textoPedido.append(" - ")
        textoPedido.append(pedidosList[indexPath.row].data)
        cell.textLabel?.text = textoPedido
        return cell
    }
    
    
    
    
    func buscaPedidos(){
        let uid = Auth.auth().currentUser?.uid.description
        refHandle = ref.child("pedidos").child(uid!).observe(.childAdded, with: { (snapshot) in
            if let dicionario = snapshot.value as? [String: AnyObject]{
                
                print(dicionario)
                
                let pedido = Pedido.init()
                var pizza = dicionario["pizza"]?.description
                var data = dicionario["data"]?.description
                
                pedido.pizza = pizza!
                pedido.data = data!
                self.pedidosList.append(pedido)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            }
        })
        
    }
    
    
}
