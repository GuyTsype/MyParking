//
//  CarDetails.swift
//  UnblockMyCar
//
//  Created by guy.tsype on 8/27/15.
//  Copyright (c) 2015 myheritage. All rights reserved.
//

import Foundation
import Parse

class CarDetails {
    
    var carOwnerName: String?
    
    var carOwnerPhone: String?
    
    var carOwnerEmail: String?
    
    
    
    init(object: PFObject) {
        
         let car = object
        
            let carName = car["carOwnerName"] as? String
            if carName != nil {
                self.carOwnerName = carName
            }
            
            
            let phoneNum = car["phoneNum"] as? String
            if phoneNum != nil {
                self.carOwnerPhone = phoneNum
            }
            
            let emailAddress = car["email"] as? String
            if emailAddress != nil {
                self.carOwnerEmail = emailAddress
                }
    
    }
    
    
    
    
    
}