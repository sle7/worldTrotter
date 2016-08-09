//
//  ConversionViewController.swift
//  WorldTrotter
//
//  Created by Sam Lee on 7/24/16.
//  Copyright © 2016 Sam Lee. All rights reserved.
//

import UIKit

class ConversionViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet var celsiusLabel: UILabel!
    @IBOutlet var textField: UITextField!
   
    // Set Number Formatter for maximum fractions to 1
    let numberFormatter: NSNumberFormatter = {
        let nf = NSNumberFormatter()
        nf.numberStyle = .DecimalStyle
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 1
        return nf
    }()
   
    // If fahrenheit value gets set, do updateCelsiusLabel
    var fahrenheitValue: Double? {
        didSet {
            updateCelsiusLabel()
        }
    }
  
    // Add computed property to celsiusValue
    var celsiusValue: Double? {
        if let value = fahrenheitValue {
            return (value-32) * (5/9)
        }
        else {
            return nil
        }
    }
    
    // gets run when view appears, check time and change background color
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let currentTime = NSDate()
        let hour = NSCalendar.currentCalendar().component(.Hour, fromDate: currentTime)
        
        switch hour {
        case 6..<17:
            //morning
            self.view.backgroundColor = UIColor.clearColor()
        case 17..<23:
            //night
            self.view.backgroundColor = UIColor.grayColor()
        default:
            //morning
            self.view.backgroundColor = UIColor.grayColor()
        }
        
    }
   
    // if textField is changed, set fahrenheitValue which also updated celsius label
    @IBAction func fahrenheitFieldEditingChanged(textField: UITextField) {
        if let text = textField.text, number = numberFormatter.numberFromString(text) {
            fahrenheitValue = number.doubleValue
        }
        else {
            fahrenheitValue = nil
        }
    }
   
    // function to remove num pad if view is pressed
    @IBAction func dismissKeyboard(sender: AnyObject) {
        textField.resignFirstResponder()
    }
    
    func updateCelsiusLabel() {
        if let value = celsiusValue {
            celsiusLabel.text = numberFormatter.stringFromNumber(value)
        }
        else {
            celsiusLabel.text = "???"
        }
    }
    
    // use a delegate to check if decimal exists in text field
    func textField(textField: UITextField,
                   shouldChangeCharactersInRange: NSRange,
                   replacementString string: String) -> Bool {
        let currentLocal = NSLocale.currentLocale()
        let decimalSeparator = currentLocal.objectForKey(NSLocaleDecimalSeparator) as! String
        
        let existingTextHasDecimalSeparator = textField.text?.rangeOfString(decimalSeparator)
        let replacementTextHasDecimalSeparator = string.rangeOfString(decimalSeparator)
        
        let replacementTextContainsAlphabet = string.rangeOfCharacterFromSet(NSCharacterSet.letterCharacterSet())
        
        if (existingTextHasDecimalSeparator != nil && replacementTextHasDecimalSeparator != nil) ||
            replacementTextContainsAlphabet != nil {
            return false
        }
        else {
            return true
        }
    }
}