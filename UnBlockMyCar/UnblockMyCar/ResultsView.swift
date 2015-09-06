//
//  ResultsView.swift
//  
//
//  Created by guy.tsype on 8/18/15.
//
//

import UIKit

import UIKit

protocol ResultsViewDelegate {
    func resultsViewCallButtonTapped(resultsView: ResultsView)
    func resultsViewEmailButtonTapped(resultsView: ResultsView)
    func resultsViewTryAnotherTapped(resultsView: ResultsView)
    func resultsViewTextButtonTapped(resultsView: ResultsView)

}

class ResultsView: UIView {
    
    var delegate: ResultsViewDelegate?
    
    var view: UIView?
    
    var nibName: String = "ResultsView"
    
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var carOwnerLabel: UILabel!
    
    
    
    @IBAction func textButton(sender: AnyObject) {
        delegate?.resultsViewTextButtonTapped(self)
    }
    


    @IBAction func tryAnother(sender: AnyObject) {
        delegate?.resultsViewTryAnotherTapped(self)
    }
    
    
    @IBAction func callButton(sender: UIButton) {
        delegate?.resultsViewCallButtonTapped(self)
    }
    
    
    @IBAction func emailButton(sender: UIButton) {
        delegate?.resultsViewEmailButtonTapped(self)
    }
    
    
    //MARK: Initialization
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
        
        
    }
    
    func loadViewFromNib() -> UIView
    {
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: nibName, bundle: bundle)
        let view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        
        return view
        
    }
    
    
}

