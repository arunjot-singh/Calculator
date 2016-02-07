//
//  ViewController.swift
//  Calculator
//
//  Created by Arunjot Singh on 1/26/16.
//  Copyright © 2016 Arunjot Singh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func preferredStatusBarStyle() -> UIStatusBarStyle {
            return UIStatusBarStyle.LightContent
       }
    
    
    @IBOutlet weak var eRaiseA: UIButton!
    @IBOutlet weak var xRaiseA: UIButton!
    @IBOutlet weak var Percentage: UIButton!
    @IBOutlet weak var xFact: UIButton!
    @IBOutlet weak var twoRootX: UIButton!
    @IBOutlet weak var Pi: UIButton!
    @IBOutlet weak var Multiply: UIButton!
    @IBOutlet weak var Divide: UIButton!
    @IBOutlet weak var Add: UIButton!
    @IBOutlet weak var Subtract: UIButton!
    @IBOutlet weak var backSpace: UIButton!
    @IBOutlet weak var displayScreen: UILabel!
    
    var labelChanged = false
    var NoDecimalYet = true
    var disableEquals = true
    var userTyping = false
    var firstNumber = Double()
    var secondNumber = Double()
    var result = Double()
    var operation = ""
    var digitsTapped = 0
    
    override func viewDidLoad() {
        backSpace.enabled = false
    }
    
    func formatLabel(var string: String) -> String {
        let length = string.characters.count
            if length == 4 {
                string.insert(",", atIndex: (string.startIndex.advancedBy(1)))
            } else if length == 6 {
                string.removeAtIndex(string.startIndex.advancedBy(1))
                string.insert(",", atIndex: (string.startIndex.advancedBy(2)))
            } else if length == 7 {
                string.removeAtIndex(string.startIndex.advancedBy(2))
                string.insert(",", atIndex: (string.startIndex.advancedBy(3)))
            } else if length == 8 {
                string.removeAtIndex(string.startIndex.advancedBy(3))
                string.insert(",", atIndex: (string.startIndex.advancedBy(1)))
                string.insert(",", atIndex: (string.startIndex.advancedBy(5)))
            } else if length == 10 {
                string.removeAtIndex(string.startIndex.advancedBy(1))
                string.insert(",", atIndex: (string.startIndex.advancedBy(2)))
                string.removeAtIndex(string.startIndex.advancedBy(5))
                string.insert(",", atIndex: (string.startIndex.advancedBy(6)))
            } else if length == 11 {
                string.removeAtIndex(string.startIndex.advancedBy(2))
                string.insert(",", atIndex: (string.startIndex.advancedBy(3)))
                string.removeAtIndex(string.startIndex.advancedBy(6))
                string.insert(",", atIndex: (string.startIndex.advancedBy(7)))
            }
            return string
    }
    
    func Numberfirst() {
        let number = displayScreen.text!
        let number1 = number.stringByReplacingOccurrencesOfString(",", withString: "")
        firstNumber = Double(number1)!
    }
    
    func Numbersecond() {
        let number = displayScreen.text!
        let number2 = number.stringByReplacingOccurrencesOfString(",", withString: "")
        secondNumber = Double(number2)!
    }
    
    func resultFormatting() {
        displayScreen.text = "\(result)"
        let substr = displayScreen.text?.substringFromIndex(displayScreen.text!.endIndex.advancedBy(-2))
        if substr == ".0" {
            var finalString = displayScreen.text?.substringToIndex(displayScreen.text!.endIndex.advancedBy(-2))
            let length = finalString!.characters.count
            if length > 9 {
                var part1 = finalString?.substringToIndex(finalString!.startIndex.advancedBy(3))
                part1?.insert(".", atIndex: (part1!.startIndex.advancedBy(1)))
                var part2 = finalString?.substringFromIndex(finalString!.startIndex.advancedBy(3))
                part2 = "e" + String(Int((part2?.characters.count)!))
                finalString = part1! + part2!
            }else {
                finalString = formatResult(finalString!)
            }
            displayScreen.text = finalString
        } else {
            var string = displayScreen.text
            let intIndex: Int = string!.startIndex.distanceTo(string!.rangeOfString(".")!.startIndex)
            var part1 = string?.substringToIndex(string!.startIndex.advancedBy(intIndex))
            var part2 = string?.substringFromIndex(string!.startIndex.advancedBy(intIndex+1))
            string = string?.stringByReplacingOccurrencesOfString(".", withString: "")
            if string?.characters.count > 9 {
                if part1?.characters.count > 8 {
                    part1 = string?.substringToIndex(string!.startIndex.advancedBy(3))
                    part1?.insert(".", atIndex: (part1!.startIndex.advancedBy(1)))
                    part2 = string?.substringFromIndex(string!.startIndex.advancedBy(3))
                    part2 = "e"+String(Int((part2?.characters.count)!))
                    string = part1! + part2!
                } else {
                    part2 = part2?.substringToIndex(part2!.startIndex.advancedBy(9-(part1?.characters.count)!))
                    string = formatResult(part1!) + "." + part2!
                }
            } else {
                string = formatResult(part1!) + "." + part2!
            }
            displayScreen.text = string
        }
    }
    
    func formatResult(var string: String) -> String {
        let length = string.characters.count
        if length == 4 {
            string.insert(",", atIndex: (string.startIndex.advancedBy(1)))
        } else if length == 5 {
            string.insert(",", atIndex: (string.startIndex.advancedBy(2)))
        } else if length == 6 {
            string.insert(",", atIndex: (string.startIndex.advancedBy(3)))
        } else if length == 7 {
            string.insert(",", atIndex: (string.startIndex.advancedBy(1)))
            string.insert(",", atIndex: (string.startIndex.advancedBy(5)))
        } else if length == 8 {
            string.insert(",", atIndex: (string.startIndex.advancedBy(2)))
            string.insert(",", atIndex: (string.startIndex.advancedBy(6)))
        } else if length == 9 {
            string.insert(",", atIndex: (string.startIndex.advancedBy(3)))
            string.insert(",", atIndex: (string.startIndex.advancedBy(7)))
        }
        return string
    }
    
    @IBAction func moreOperations(sender: UIBarButtonItem) {
        if labelChanged == false {
            eRaiseA.setTitle("eª", forState: .Normal)
            xRaiseA.setTitle("xª", forState: .Normal)
            xFact.setTitle("log", forState: .Normal)
            twoRootX.setTitle("ln", forState: .Normal)
            Percentage.setTitle("1/x", forState: .Normal)
            Pi.setTitle("ʸ√x", forState: .Normal)
            Multiply.setTitle("Sin", forState: .Normal)
            Divide.setTitle("Cos", forState: .Normal)
            Add.setTitle("Tan", forState: .Normal)
            Subtract.setTitle("Rand", forState: .Normal)
            labelChanged = true
        } else {
            eRaiseA.setTitle("e", forState: .Normal)
            xRaiseA.setTitle("x²", forState: .Normal)
            xFact.setTitle("x!", forState: .Normal)
            twoRootX.setTitle("√x", forState: .Normal)
            Percentage.setTitle("%", forState: .Normal)
            Pi.setTitle("π", forState: .Normal)
            Multiply.setTitle("×", forState: .Normal)
            Divide.setTitle("÷", forState: .Normal)
            Add.setTitle("+", forState: .Normal)
            Subtract.setTitle("-", forState: .Normal)
            labelChanged = false
        }
    }
    
    @IBAction func digitTapped(sender: UIButton) {
        if digitsTapped <= 8 {
        let digit = sender.currentTitle
        if userTyping == true {
            if NoDecimalYet == true {
                displayScreen.text = formatLabel(displayScreen.text! + digit!)
            } else {
                displayScreen.text = displayScreen.text! + digit!
                }
            userTyping = true
        } else {
            if digit == "0" {
                displayScreen.text = displayScreen.text!
                userTyping = false
            } else {
                displayScreen.text = digit
                userTyping = true
               }
          }
            var number = displayScreen.text!.stringByReplacingOccurrencesOfString(",", withString: "")
            number = number.stringByReplacingOccurrencesOfString(".", withString: "")
            digitsTapped = number.characters.count
        }
        disableEquals = false
        backSpace.enabled = true
    }
    
    
   
    @IBAction func pointTapped(sender: UIButton) {
        let pointSymbol = sender.currentTitle!
        if userTyping == true {
            if displayScreen.text?.rangeOfString(pointSymbol) == nil {
                displayScreen.text = displayScreen.text! + pointSymbol
            }
        } else {
            displayScreen.text = "0" + pointSymbol
            userTyping = true
        }
        NoDecimalYet = false
        backSpace.enabled = true
    }
    
    @IBAction func Operation(sender: UIButton) {
        Numberfirst()
        operation = sender.currentTitle!
        if operation == "e" {
            result = 2.71828
            resultFormatting()
            backSpace.enabled = false
        }else if operation == "eª" {
            result = pow(2.71828, firstNumber)
            resultFormatting()
            backSpace.enabled = false
        }else if operation == "ln" {
            result = log(firstNumber)
            resultFormatting()
            backSpace.enabled = false
        }else if operation == "1/x" {
            result = 1/firstNumber
            resultFormatting()
            backSpace.enabled = false
        }else if operation == "x²" {
            result = firstNumber * firstNumber
            resultFormatting()
            backSpace.enabled = false
        }else if operation == "π" {
            result = 3.14159
            resultFormatting()
            backSpace.enabled = false
        }else if operation == "√x" {
            result = sqrt(firstNumber)
            resultFormatting()
            backSpace.enabled = false
        }else if operation == "Rand" {
            result = drand48()
            resultFormatting()
            backSpace.enabled = false
        }else if operation == "Sin" {
            result = sin((firstNumber*3.14159)/180)
            resultFormatting()
            backSpace.enabled = false
        }else if operation == "Cos" {
            result = cos((firstNumber*3.14159)/180)
            resultFormatting()
            backSpace.enabled = false
        }else if operation == "Tan" {
            result = tan((firstNumber*3.14159)/180)
            resultFormatting()
            backSpace.enabled = false
        }
        userTyping = false
        disableEquals = true
        digitsTapped = 0
        NoDecimalYet = true
    }
  
    @IBAction func xFactNLog(sender: UIButton) {
        Numberfirst()
        operation = sender.currentTitle!
        if operation == "log" {
            result = log10(firstNumber)
        }else {
            result = factorial(firstNumber)
        }
        resultFormatting()
        userTyping = false
        disableEquals = true
        backSpace.enabled = false
    }
    
    @IBAction func equals(sender: UIButton) {
        if disableEquals == false {
        
        if operation == "" {
            if userTyping == false {
            displayScreen.text = "0"
            } else {
                displayScreen.text = displayScreen.text!
            }
            backSpace.enabled = true
        } else {
            Numbersecond()
            if operation == "+" {
                result = firstNumber + secondNumber
            }else if operation == "-" {
                result = firstNumber - secondNumber
            }else if operation == "×" {
                result = firstNumber * secondNumber
            }else if operation == "÷" {
                result = firstNumber / secondNumber
            }else if operation == "xª" {
                result = pow(firstNumber, secondNumber)
            }else if operation == "ʸ√x" {
                result = pow(firstNumber, (1/secondNumber))
            }else if operation == "% " {
                result = (firstNumber / 100) * secondNumber
            }
            resultFormatting()
            backSpace.enabled = false
            }
        }
        userTyping = false
        disableEquals = true
        
    }

     @IBAction func clear(sender: UIButton) {
        firstNumber = 0
        secondNumber = 0
        displayScreen.text = "0"
        digitsTapped = displayScreen.text!.characters.count
        userTyping = false
        NoDecimalYet = true
    }
    
    @IBAction func backSpace(sender: UIButton) {
         if displayScreen.text?.rangeOfString(".") != nil {
            NoDecimalYet = false
         } else {
            NoDecimalYet = true
        }
        var truncated = String(displayScreen.text!.characters.dropLast())
        let length = truncated.characters.count
        let char = "," as Character
       
        if NoDecimalYet == true {
            if length == 0 {
                truncated = "0"
            }else if length == 4 {
                truncated.removeAtIndex(truncated.startIndex.advancedBy(1))
            } else if length == 5 {
                truncated.removeAtIndex(truncated.startIndex.advancedBy(2))
                truncated.insert(char, atIndex: truncated.startIndex.advancedBy(1))
            } else if length == 6 {
                truncated.removeAtIndex(truncated.startIndex.advancedBy(3))
                truncated.insert(char, atIndex: truncated.startIndex.advancedBy(2))
            } else if length == 8 {
                truncated.removeAtIndex(truncated.startIndex.advancedBy(1))
                truncated.removeAtIndex(truncated.startIndex.advancedBy(4))
                truncated.insert(char, atIndex: truncated.startIndex.advancedBy(3))
            } else if length == 9 {
                truncated.removeAtIndex(truncated.startIndex.advancedBy(2))
                truncated.removeAtIndex(truncated.startIndex.advancedBy(5))
                truncated.insert(char, atIndex: truncated.startIndex.advancedBy(1))
                truncated.insert(char, atIndex: truncated.startIndex.advancedBy(5))
            } else if length == 9 {
                truncated.removeAtIndex(truncated.startIndex.advancedBy(3))
                truncated.insert(char, atIndex: truncated.startIndex.advancedBy(2))
                truncated.removeAtIndex(truncated.startIndex.advancedBy(5))
                truncated.insert(char, atIndex: truncated.startIndex.advancedBy(5))
            } else if length == 10 {
                truncated.removeAtIndex(truncated.startIndex.advancedBy(3))
                truncated.insert(char, atIndex: truncated.startIndex.advancedBy(2))
                truncated.insert(char, atIndex: truncated.startIndex.advancedBy(6))
                truncated.removeAtIndex(truncated.startIndex.advancedBy(8))
            }
        }
        displayScreen.text = truncated
        if truncated == "0" {
            userTyping = false
        }else{
            userTyping = true
        }
    }
    
    func factorial(n: Double) -> Double {
        if n >= 0 {
            return n == 0 ? 1 : n * self.factorial(n - 1)
        } else {
            userTyping = false
            return 0 / 0
        }
    }
    
}


