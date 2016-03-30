//
//  File.swift
//  CoreTeste
//
//  Created by Athila Zuma on 30/03/16.
//  Copyright © 2016 Hangout Ltda. All rights reserved.
//

import UIKit

class users {
    var username : String
    var sexo : String
    var password : String
    
    init?(username : String, sexo : String, password : String) {
        
        self.username = username
        self.sexo = sexo
        self.password = password
    }
    
}
