//
//  SubmitView.swift
//  UnblockMyCar
//
//  Created by guy.tsype on 8/18/15.
//  Copyright (c) 2015 myheritage. All rights reserved.
//

import UIKit

protocol SubmitViewDelegate {
    func submitViewButtonTapped(submitView: SubmitView)
}

class SubmitView: UIView, UIApplicationDelegate {
    
    var delegate: SubmitViewDelegate?
    var carNumber: Int?
    
        
    @IBOutlet weak var alertLabel: UILabel!
    
    
    @IBAction func submitButton(sender: UIButton) {
        println("button pressed")
        
        
        if textField.text != "" {
            carNumber = textField.text.toInt()
        delegate?.submitViewButtonTapped(self)
        } else {
                alertLabel.text = "*Please enter a license plate number"
                alertLabel.textColor = UIColor.orangeColor()
            }
        
        }
    
    
    
    var view: UIView?
    
    var nibName: String = "SubmitView"
    
    @IBOutlet weak var textField: UITextField!

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        
                
    }
    
    func setup() {
        view = loadViewFromNib()
        
        view!.frame = bounds
        view!.autoresizingMask = UIViewAutoresizing.FlexibleHeight | UIViewAutoresizing.FlexibleWidth
        
        addSubview(view!)
        alertLabel.text = ""
        
    }
 
    func loadViewFromNib() -> UIView
    {
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: nibName, bundle: bundle)
        let view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        
        return view
    }
    
    


}
