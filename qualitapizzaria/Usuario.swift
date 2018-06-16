//
//  Usuario.swift
//  qualitapizzaria
//
//  Created by Yuri Fernando Wanderley Silva on 02/06/18.
//  Copyright © 2018 Yuri Fernando Wanderley Silva. All rights reserved.
//

import UIKit

class Usuario: NSObject{
    var login: String
    var endereco: String
    var telefone: String
    
    override init(){
        self.login = ""
        self.endereco = ""
        self.telefone = ""
    }
    
    init(login: String, endereco: String, telefone: String) {
        self.login = login
        self.endereco = endereco
        self.telefone = telefone
    }
}
