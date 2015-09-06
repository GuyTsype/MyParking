//
//  DataRetriever .swift
//  UnblockMyCar
//
//  Created by guy.tsype on 8/26/15.
//  Copyright (c) 2015 myheritage. All rights reserved.
//

import Foundation
import UIKit
import Parse

class DataRetriever {

    var query = PFQuery(className: "Car")
    
    var carNum: Int?
    
    var errorMessage: String?
    
    init (){

    }
    
    func retrieveCarOwnerInfo(car: Int, completionClosure: (error: NSError?,car: CarDetails?) -> Void) {
        
        
        query.whereKey("carNumber", equalTo: car).getFirstObjectInBackgroundWithBlock { (object, error) -> Void in
            
            var car: CarDetails?
            
            if error != nil
            {
                print(error)
                
                
            } else {
                
                 car = CarDetails(object: object!)
            }
            
            completionClosure(error: error, car: car)
                
                
                
                
            
            
            
        }
    }
    
    
    
}





























