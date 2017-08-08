//
//  ViewController.swift
//  Calculator
//
//  Created by Jenna Brown on 02/08/2017.
//  Copyright © 2017 Jbro. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
    
    private var userIsInTheMiddleOfTyping = false

    @IBAction func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTyping{
        let textCurrentlyInDisplay = display.text!
        display!.text! = textCurrentlyInDisplay + digit
        }
        else {
            display.text! = digit
        }
        userIsInTheMiddleOfTyping = true
    }
    
//    private var displayValue: Double {
//        get {
//            return Double(display!.text!)!
//        }
//        set(value) {
//            display!.text = String(value)
//        }
//    }

    @IBAction func performOperation(_ sender: UIButton) {
        
        
    }
}

