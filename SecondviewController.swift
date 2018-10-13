//
//  SecondviewController.swift
//  multiwindowforcalci
//
//  Created by Venkatesh K on Saka 1940-07-20.
//  Copyright © 1940 Saka Venkatesh K. All rights reserved.
//

import UIKit

class SecondviewController: UIViewController {

    @IBOutlet weak var lblValue: UILabel!
    
    
    var numberOnScreen: Double = 0;
    var previousNumber: Double = 0;
    var performingMath = false;
    var performingMath2 = false;
    var isEqulAction = false;
    var isFloatingAction = false;
    var operation = 0;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    @IBAction func calculations(_ sender: UIButton) {
        
        if sender.tag >= 0 && sender.tag <= 9 {
            if isFloatingAction == true
            {
                lblValue.text = lblValue.text! + String(sender.tag)
                numberOnScreen = Double(lblValue.text!)!
            } else if performingMath == true {
                previousNumber = Double(lblValue.text!)!
                lblValue.text = String(sender.tag)
                numberOnScreen = Double(lblValue.text!)!
                performingMath = false
                performingMath2 = true
            } else if isEqulAction == true {
                lblValue.text = String(sender.tag)
                numberOnScreen = Double(lblValue.text!)!
                performingMath = false
                performingMath2 = false
                previousNumber = 0
                isEqulAction = false
            } else {
                if lblValue.text == "0"
                {
                    lblValue.text = String(sender.tag)
                }else
                {
                    lblValue.text = lblValue.text! + String(sender.tag)
                }
                numberOnScreen = Double(lblValue.text!)!
            }
        } else if sender.tag == 18 {
            lblValue.text = "0"
            previousNumber = 0;
            numberOnScreen = 0;
            operation = 0;
            performingMath2 = false
            performingMath = false
            isFloatingAction = false
        } else if sender.tag == 17 {
            if lblValue.text! != "0"
            {
                if ((lblValue.text! as NSString).range(of: "-") as NSRange).length != 0
                {
                    lblValue.text = (lblValue.text! as NSString) .replacingOccurrences(of: "-", with: "")
                }
                else
                {
                    lblValue.text = "-" + lblValue.text!
                }
                numberOnScreen = Double(lblValue.text!)!
            }
            
        }  else if sender.tag == 10 && lblValue.text != "" {
            
            if ((lblValue.text! as NSString).range(of: ".") as NSRange).length == 0
            {
                isFloatingAction = true
                lblValue.text =  lblValue.text! + "."
                numberOnScreen = Double(lblValue.text!)!
            }
            
        } else if sender.tag == 16 && lblValue.text != "0" {
            isEqulAction = true
            lblValue.text = String(numberOnScreen/100)
            numberOnScreen = Double(lblValue.text!)!
            isFloatingAction = false
            
        } else if sender.tag == 19 && lblValue.text != "0" {
            isEqulAction = true
            lblValue.text = String(sqrt(numberOnScreen))
            numberOnScreen = Double(lblValue.text!)!
            isFloatingAction = false
            
        } else if lblValue.text != "0" && (sender.tag >= 12 && sender.tag <= 15)
        {
            
            if performingMath2 == true
            {
                mathCalculations()
                performingMath2 = false
                
            }else
            {
                previousNumber = 0;
            }
            operation = sender.tag
            performingMath = true
            isFloatingAction = false
            
        } else if lblValue.text != "" && sender.tag == 11 {
            
            isEqulAction = true
            isFloatingAction = false
            if operation > 0
            {
                mathCalculations()
                
                
                performingMath2 = false
                performingMath = false
                operation = 0
            }
            
        }
    }
    
    func mathCalculations() {
        var strValue : String = "0"
        if operation == 15 { //Divide
            if numberOnScreen == 0
            {
                strValue = ""
                lblValue.text = "Not a Number"
                previousNumber = 0
                numberOnScreen = 0
                
            }else
            {
                strValue = String(previousNumber / numberOnScreen)
            }
        }
            
        else if operation == 14{ //Multiply
            strValue  = String(previousNumber * numberOnScreen)
        }
            
        else if operation == 13{ //Subtract
            print((previousNumber - numberOnScreen))
            strValue  = String(previousNumber - numberOnScreen)
        }
            
        else if operation == 12{ //Add
            strValue = String(previousNumber + numberOnScreen)
        }
        
        if strValue.count > 0 {
            lblValue.text = convertNumber(str: strValue)
            numberOnScreen = Double(lblValue.text!)!
        }
        
    }
    
    func convertNumber(str:String) -> String
    {
        let aryValues = str.split(separator: ".")
        let valueGet = String(aryValues[1])
        if Int(valueGet)! > 0
        {
            return String(format: "%f", Double(str) ?? 0.0)
        }
        return String(aryValues[0])
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

