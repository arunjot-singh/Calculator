//
//  ViewController.swift
//  Calculator
//
//  Created by Arunjot Singh on 1/26/16.
//  Copyright © 2016 Arunjot Singh. All rights reserved.
//

import UIKit
extension Double {
    var addSeparator: String {
        let nf = NSNumberFormatter()
        nf.groupingSeparator = ","
        nf.numberStyle = NSNumberFormatterStyle.DecimalStyle
        return nf.stringFromNumber(self)!
    }
}
extension Double {
    var scientificStyle: String {
        let nf = NSNumberFormatter()
        nf.numberStyle = .ScientificStyle
        nf.positiveFormat = "0.###E+00"
        nf.negativeFormat = "0.###E-00"
        nf.exponentSymbol = "e"
        return nf.stringFromNumber(self)!
    }
}
extension Double {
    var decimalStyle: String {
        let nf = NSNumberFormatter()
        nf.numberStyle = .DecimalStyle
        return nf.stringFromNumber(self)!
    }
}

extension Double {
    func roundToPlaces(places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return round(self * divisor) / divisor
    }
}

class ViewController: UIViewController {

    override func preferredStatusBarStyle() -> UIStatusBarStyle {
            return UIStatusBarStyle.LightContent
       }
    override func shouldAutorotate() -> Bool {
        return false
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
    @IBOutlet weak var displayScreen: UILabel!
    
    var backspace = false
    var NoDecimalYet = true
    var disableEquals = true
    var userTyping = false
    var firstNumber = Double()
    var secondNumber = Double()
    var result = Double()
    var operation = ""
    var digitsTapped = 0
   
    
    override func viewDidLoad() {
        let swipeUp = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.respond(_:)))
        swipeUp.direction = .Up
        view.addGestureRecognizer(swipeUp)
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.respond(_:)))
        swipeDown.direction = .Down
        view.addGestureRecognizer(swipeDown)
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.respond(_:)))
        swipeRight.direction = .Right
        view.addGestureRecognizer(swipeRight)
    }
    
    func respond(gesture: UIGestureRecognizer){
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.Up:
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
            case UISwipeGestureRecognizerDirection.Down:
                eRaiseA.setTitle("e", forState: .Normal)
                xRaiseA.setTitle("x²", forState: .Normal)
                xFact.setTitle("x!", forState: .Normal)
                twoRootX.setTitle("√x", forState: .Normal)
                Percentage.setTitle("%", forState: .Normal)
                Pi.setTitle("π", forState: .Normal)
                Multiply.setTitle("×", forState: .Normal)
                Divide.setTitle("÷", forState: .Normal)
                Add.setTitle("+", forState: .Normal)
                Subtract.setTitle("−", forState: .Normal)
            default:
                if backspace == true {
                    var string = displayScreen.text
                    string = string?.stringByReplacingOccurrencesOfString(",", withString: "")
                    let length = string?.characters.count
                    if length == 1 {
                        displayScreen.text = "0"
                    }else{
                        let truncated = String(string!.characters.dropLast())
                        result = Double(truncated)!
                        displayScreen.text = "\(result.addSeparator)"
                    }
                }
                if displayScreen.text == "0" {
                    userTyping = false
                }else{
                    userTyping = true
                }
            }
        }
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
        if displayScreen.text == "inf" {
            displayScreen.text = "Error"
        }else{
        let substr = displayScreen.text?.substringFromIndex(displayScreen.text!.endIndex.advancedBy(-2))
        if substr == ".0" {
            let finalString = displayScreen.text?.substringToIndex(displayScreen.text!.endIndex.advancedBy(-2))
            let length = finalString!.characters.count
            if length > 9 {
                result = Double(finalString!)!
                displayScreen.text = "\(result.scientificStyle)"
           }else {
                result = Double(finalString!)!
                displayScreen.text = "\(result.addSeparator)"
            }
        } else {
            let string = displayScreen.text
            let str = displayScreen.text?.substringToIndex(displayScreen.text!.startIndex.advancedBy(2))
            if str == "0." {
                result = Double(string!)!
                displayScreen.text = "\(result.roundToPlaces(8))"
            }else{
                if string!.rangeOfString("e") == nil {
                    let str = string?.stringByReplacingOccurrencesOfString(".", withString: "")
                    let length = str?.characters.count
                    if length > 9 {
                        let intIndex: Int = string!.startIndex.distanceTo(string!.rangeOfString(".")!.startIndex)
                        let part1 = string?.substringToIndex(string!.startIndex.advancedBy(intIndex))
                        var part2 = string?.substringFromIndex(string!.startIndex.advancedBy(intIndex+1))
                        if part1?.characters.count < 7 {
                            part2 = part2?.substringToIndex((part2?.startIndex.advancedBy(9-(part1?.characters.count)!))!)
                            result = Double(part1!)!
                            displayScreen.text = "\(result.addSeparator)." + part2!
                        }else{
                            result = Double(str!)!
                            displayScreen.text = "\(result.scientificStyle)"
                        }
                    }else{
                        let intIndex: Int = string!.startIndex.distanceTo(string!.rangeOfString(".")!.startIndex)
                        let part1 = string?.substringToIndex(string!.startIndex.advancedBy(intIndex))
                        let part2 = string?.substringFromIndex(string!.startIndex.advancedBy(intIndex+1))
                        result = Double(part1!)!
                        displayScreen.text = "\(result.addSeparator)." + part2!
                    }
                }else{
                    if string?.characters.count > 9 {
                        let intIndex: Int = string!.startIndex.distanceTo((string!.rangeOfString("e")!.startIndex))
                        let part1 = string?.substringToIndex(string!.startIndex.advancedBy(5))
                        let part2 = string?.substringFromIndex(string!.startIndex.advancedBy(intIndex))
                        displayScreen.text = part1! + part2!
                    }else{
                        displayScreen.text = string
                    }
                }
            }
            }
        }
    }
    
    @IBAction func digitTapped(sender: UIButton) {
        if digitsTapped <= 8 {
        let digit = sender.currentTitle
        if userTyping == true {
            if NoDecimalYet == true {
                var str = displayScreen.text! + digit!
                str = str.stringByReplacingOccurrencesOfString(",", withString: "")
                result = Double(str)!
                displayScreen.text = "\(result.addSeparator)"
            } else {
                displayScreen.text = displayScreen.text! + digit!
                }
            userTyping = true
        } else {
            if digit == "0" {
               displayScreen.text = "0"
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
        backspace = true
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
        backspace = true
    }
    
    @IBAction func Operation(sender: UIButton) {
        if displayScreen.text == "Error" {
            displayScreen.text = "0"
        }else{
            Numberfirst()
        operation = sender.currentTitle!
        if operation == "e" {
            result = 2.71828
            resultFormatting()
        }else if operation == "eª" {
            result = pow(2.71828, firstNumber)
            resultFormatting()
        }else if operation == "ln" {
            if firstNumber > 0 {
                result = log(firstNumber)
                displayScreen.text = "\(result.roundToPlaces(8))"
            }else{
                displayScreen.text = "Error"
            }
        }else if operation == "1/x" {
            if firstNumber == 0 {
                displayScreen.text = "Error"
            }else{
                result = 1/firstNumber
                resultFormatting()
            }
        }else if operation == "x²" {
            result = firstNumber * firstNumber
            resultFormatting()
        }else if operation == "π" {
            result = 3.14159
            resultFormatting()
        }else if operation == "√x" {
            if firstNumber >= 0 {
            result = sqrt(firstNumber)
            resultFormatting()
            }else{
                displayScreen.text = "Error"
            }
        }else if operation == "Rand" {
            result = drand48()
            displayScreen.text = "\(result.roundToPlaces(8))"
        }else if operation == "Sin" {
            result = sin((firstNumber*3.14159)/180)
            displayScreen.text = "\(result.roundToPlaces(8))"
        }else if operation == "Cos" {
            result = cos((firstNumber*3.14159)/180)
            displayScreen.text = "\(result.roundToPlaces(8))"
        }else if operation == "Tan" {
            result = tan((firstNumber*3.14159)/180)
            displayScreen.text = "\(result.roundToPlaces(8))"
        }
        }
        userTyping = false
        disableEquals = true
        digitsTapped = 0
        NoDecimalYet = true
        backspace = false
    }
  
    @IBAction func xFactNLog(sender: UIButton) {
        if displayScreen.text != "Error" {
                Numberfirst()
                operation = sender.currentTitle!
                if operation == "log" {
                    if firstNumber > 0 {
                        result = log10(firstNumber)
                        displayScreen.text = "\(result.roundToPlaces(8))"
                    }else{
                        displayScreen.text = "Error"
                    }
                }else {
                    if NoDecimalYet == true {
                        if firstNumber < 0 {
                            displayScreen.text = "Error"
                        }else {
                            result = factorial(firstNumber)
                            resultFormatting()
                        }
                    }else {
                        result = tgamma(firstNumber+1)
                        var string = "\(result.roundToPlaces(8))"
                        if string.characters.count > 9 {
                            string = string.stringByReplacingOccurrencesOfString(".", withString: "")
                            result = Double(string)!
                            displayScreen.text = "\(result.scientificStyle)"
                        }else{
                            displayScreen.text = string
                        }
                    }
                }
        }else{
            displayScreen.text = "0"
        }
        userTyping = false
        disableEquals = true
        backspace = false
    }
    
    @IBAction func equals(sender: UIButton) {
        if disableEquals == false {
        
        if operation == "" {
            if userTyping == false {
            displayScreen.text = "0"
            } else {
                displayScreen.text = displayScreen.text!
            }
        } else {
            Numbersecond()
            if operation == "+" {
                result = firstNumber + secondNumber
                var string = "\(result)"
                string = string.stringByReplacingOccurrencesOfString(".", withString: "")
                result = Double(string)!
                resultFormatting()
            }else if operation == "−" {
                result = firstNumber - secondNumber
                resultFormatting()
            }else if operation == "×" {
                result = firstNumber * secondNumber
                resultFormatting()
            }else if operation == "÷" {
                result = firstNumber / secondNumber
                resultFormatting()
            }else if operation == "xª" {
                result = pow(firstNumber, secondNumber)
                resultFormatting()
            }else if operation == "ʸ√x" {
                if secondNumber <= 0 || firstNumber < 0 {
                    displayScreen.text = "Error"
                }else{
                    result = pow(firstNumber, (1/secondNumber))
                    resultFormatting()
                }
            }else if operation == "% " {
                result = (firstNumber / 100) * secondNumber
                resultFormatting()
            }
            }
        }
        userTyping = false
        disableEquals = true
        backspace = false
    }

     @IBAction func clear(sender: UIButton) {
        firstNumber = 0
        secondNumber = 0
        displayScreen.text = "0"
        digitsTapped = displayScreen.text!.characters.count
        userTyping = false
        NoDecimalYet = true
    }
    
    func factorial(n: Double) -> Double {
        if n >= 0 {
            return n == 0 ? 1 : n * self.factorial(n - 1)
        } else {
            return 0 / 0
        }
    }
    
}


