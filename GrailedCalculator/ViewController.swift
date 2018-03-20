//
//  ViewController.swift
//  GrailedCalculator
//
//  Created by Matt. on 2/11/18.
//  Copyright © 2018 mbenn. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var grailedLabel: UILabel!
    @IBOutlet weak var paypalLabel: UILabel!
    @IBOutlet weak var takehomeLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var calculateButton: UIButton!
    @IBOutlet weak var internationalSwitch: UISwitch!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calculateButton.layer.cornerRadius = 8
        internationalSwitch.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        // Do any additional setup after loading the view, typically from a nib.
    } // end of function viewDidLoad
    
    @IBAction func ifEnteringInput(_ sender: Any) {
        messageLabel.text = ""
    } // end of function to see if they're inputting data (to make empty input label blank)
    
    @IBAction func didBeginEditing(_ sender: Any) {
        if textField.text == "" {
            textField.placeholder = ""
        } // end if need to set placeholder to blank
    } // end of function didBeginEditing
    
    @IBAction func didEndEditing(_ sender: Any) {
        if textField.text == "" {
            textField.placeholder = "price"
        } // end if need to set placeholder to price
    } // end of function didEndEditing
    
    @IBAction func calculate(_ sender: Any) {
        
        if textField.text!.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            messageLabel.text = "Please enter the sale price."
            messageLabel.textAlignment = NSTextAlignment.center
            grailedLabel.text = "Grailed Fees:  "
            paypalLabel.text = "PayPal Fees:  "
            takehomeLabel.text = "Takehome:  "
            self.view.endEditing(true)
            return
        } // end if checking for empty input
        
        guard Int(textField.text!) != nil else {
            textField.text = ""
            messageLabel.text = "What are you trying to do?"
            messageLabel.textAlignment = NSTextAlignment.center
            grailedLabel.text = "Grailed Fees:  "
            paypalLabel.text = "PayPal Fees:  "
            takehomeLabel.text = "Takehome:  "
            self.view.endEditing(true)
            return
        } // end if checking for bad characters
        
        if Int(textField.text!)! <= 0 {
            messageLabel.text = "Please enter the sale price."
            messageLabel.textAlignment = NSTextAlignment.center
            grailedLabel.text = "Grailed Fees:  "
            paypalLabel.text = "PayPal Fees:  "
            takehomeLabel.text = "Takehome:  "
            self.view.endEditing(true)
            return
        } // end if empty input
        
        // irrelevant now, this was before I was able to limit the number of characters, but want to leave it in here
        if textField.text!.count > 5 {
            messageLabel.text = "You aren't selling it for that price."
            messageLabel.textAlignment = NSTextAlignment.center
            grailedLabel.text = "Grailed Fees:  "
            paypalLabel.text = "PayPal Fees:  "
            takehomeLabel.text = "Takehome:  "
            self.view.endEditing(true)
            return
        } // end if length of price is too large
        
        
        // where the actual math begins
        var paypalPercentage:Double;
        if internationalSwitch.isOn {
            paypalPercentage = 0.044
        } // end if international switch is "off"
        else {
            paypalPercentage = 0.029
        } // end else, the international switch is "on"
        
        let salePrice: Double? = Double(textField.text!)
        let grailedFee = round(100 * salePrice! * 0.06) / 100
        let paypalFee = round(100 * salePrice! * paypalPercentage) / 100 + 0.30
        let takehomeCalculation = salePrice! - (grailedFee + paypalFee)
        let takehome = round(100 * (takehomeCalculation)) / 100
        
        messageLabel.text = ""
        grailedLabel.text = "Grailed Fees:  " + String(format: "%.2f", grailedFee)
        paypalLabel.text = "PayPal Fees:  " + String(format: "%.2f", paypalFee)
        takehomeLabel.text = "Takehome:  " + String(format: "%.2f", takehome)
        
        self.view.endEditing(true)
        
    } // end of function calculate
    
    @IBAction func internationalSwitched(_ sender: Any) {
        calculate(sender);
    } // end of function internationalSwitched
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    } // end of function didReceiveMemoryWarning
    
} // end of ViewController
