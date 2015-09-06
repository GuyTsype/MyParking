//
//  ViewController.swift
//  UnblockMyCar
//
//  Created by guy.tsype on 8/18/15.
//  Copyright (c) 2015 myheritage. All rights reserved.
//

import UIKit
import MessageUI

class ViewController: UIViewController, MFMailComposeViewControllerDelegate, SubmitViewDelegate, ResultsViewDelegate {
    
   
    @IBOutlet weak var implView: UIView!
    
    var firstView: SubmitView!
    var secondView: ResultsView!
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    var dataRet = DataRetriever()
    var car: CarDetails?
    var transitionOptions = UIViewAnimationOptions.TransitionFlipFromBottom
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

    
        // Activity indicator
        activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.Gray)
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        
        self.view!.addSubview(activityIndicator)
        self.view.bringSubviewToFront(activityIndicator)
 
    }
    
    override func viewWillAppear(animated: Bool) {
        if firstView == nil {
        firstView = SubmitView(frame: implView.bounds)
        firstView.delegate = self
        implView.addSubview(firstView)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        firstView.frame = implView.bounds
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //Mark: delegate functions
    
    //Submit button prompts the Parse query and creates a car object
    func submitViewButtonTapped(submitView: SubmitView) {
        secondView = ResultsView(frame: implView.frame)
        secondView.delegate = self
        showAlert()

        firstView.textField.text = ""
        firstView.textField.resignFirstResponder()
        dataRet.retrieveCarOwnerInfo(submitView.carNumber!) { (error, car) -> Void in
            self.hide()
            if error != nil {
                self.firstView.alertLabel.text = "Couldn't find car, please try another number"
            } else {
            self.car = car

                UIView.transitionWithView(self.implView, duration: 1.0, options: self.transitionOptions, animations: {
                    // remove the front object...
                    self.firstView.hidden = true
                    
                    // ... and add the other object
                    self.implView.addSubview(self.secondView)
                    
                    }, completion: { finished in
                        self.secondView.carOwnerLabel.text = "The car belongs to \(car!.carOwnerName!)"
                })
                
//            self.firstView.hidden = true
//            self.secondView.carOwnerLabel.text = "The car belongs to \(car!.carOwnerName!)"
//            self.implView.addSubview(self.secondView)
            
            }
        }
    }
    
    
    
    func resultsViewEmailButtonTapped(resultsView: ResultsView) {
        let url = NSURL(string: car!.carOwnerEmail!)!
        let mailComposeViewController = configuredMailComposeViewController()
        if MFMailComposeViewController.canSendMail() {
            self.presentViewController(mailComposeViewController, animated: true, completion: nil)
        } else {
            self.showSendMailErrorAlert()
        }
        self.firstView.hidden = true
    }
    
    func resultsViewTextButtonTapped(resultsView: ResultsView) {
        let url:NSURL = NSURL(string: "sms:0\(car!.carOwnerPhone!)")!
        UIApplication.sharedApplication().openURL(url);
    }
    
    func resultsViewCallButtonTapped(resultsView: ResultsView) {
        let url = NSURL(string: "tel://\(car!.carOwnerPhone!)")!
        UIApplication.sharedApplication().openURL(url)
        
    }
    
    func resultsViewTryAnotherTapped(resultsView: ResultsView) {
//        secondView.hidden = true
//        firstView.hidden = false
        firstView.alertLabel.text = ""
        UIView.transitionWithView(self.implView, duration: 1.0, options: self.transitionOptions, animations: {
            // remove the front object...
            self.secondView.hidden = true
            
            // ... and add the other object
            self.firstView.hidden = false
            
            }, completion: { finished in
                self.firstView.alertLabel.text = ""
        })

    }
    
    //MARK: Alert helper function
    func showSendMailErrorAlert() {
        let sendMailErrorAlert = UIAlertView(title: "Could Not Send Email", message: "Your device could not send e-mail.  Please check e-mail configuration and try again.", delegate: self, cancelButtonTitle: "OK")
        sendMailErrorAlert.show()
    }
    
    func showAlert() {
        activityIndicator.startAnimating()
        UIApplication.sharedApplication().beginIgnoringInteractionEvents()
    }
    
    func hide() {
        activityIndicator.stopAnimating()
        UIApplication.sharedApplication().endIgnoringInteractionEvents()
    }
    
    
    // MARK: Mail helper functions
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        controller.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self // Extremely important to set the --mailComposeDelegate-- property, NOT the --delegate-- property
        
        mailComposerVC.setToRecipients(["\(car!.carOwnerEmail!)"])
        mailComposerVC.setSubject("Hi \(car!.carOwnerName!), You're car is blocking my car!")
        mailComposerVC.setMessageBody("Dear \(car!.carOwnerName!), Pleas come unblock my car", isHTML: false)
        
        return mailComposerVC
    }

    
}

