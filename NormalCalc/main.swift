//
//  main.swift
//  SimpleCalc
//
//  Created by Joshua Malters on 10/12/15.
//  Copyright © 2015 Joshua Malters. All rights reserved.
//

import Foundation

// returns the string entered in by the console
func input() -> String {
    let keyboard = NSFileHandle.fileHandleWithStandardInput()
    let inputData = keyboard.availableData
    let result = NSString(data: inputData, encoding:NSUTF8StringEncoding) as! String
    return result.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
}

// turns strings into ints!
func convertInt(incoming:String) -> Int {
    return NSNumberFormatter().numberFromString(incoming)!.integerValue
}

func convertFloat(incoming:String) -> Float {
    return NSNumberFormatter().numberFromString(incoming)!.floatValue
}

// returns int value the calculated result for single operand operations
func parseOperandAndCalc(operand: String, x:Int, y:Int) -> Int {
    switch operand {
    case "+":
        return calculate(<#T##x: Int##Int#>, y: <#T##Int#>, operation: add)
    case "-":
        return x - y
    case "*":
        return x * y
    case "/":
        return x / y
    case "%":
        return x % y
    default:
        print("Not a recognized operation, presenting -1. ")
        return -1;
    }
}

// returns float value the calculated result for single operand operations
func parseOperandAndCalc(operand: String, x:Float, y:Float) -> Float {
    switch operand {
    case "+":
        return x + y
    case "-":
        return x - y
    case "*":
        return x * y
    case "/":
        return x / y
    case "%":
        return x % y
    default:
        print("Not a recognized operation, presenting -1.0 ")
        return -1.0;
    }
}



// returns the calculated result for multi-operand calculations
func parseMultiOperandAndCalc(operand:[String]) -> Int {
    switch operand[operand.count - 1] {
    case "count":
        return operand.count - 1
    case "avg":
        var sum = 0
        for var i = 0; i < operand.count - 1; i++ {
            sum = sum + convertInt(operand[i])
        }
        return sum / (operand.count - 1)
    case "fact":
        if operand.count > 2 {
            print("fact can only take in one number, returning -1")
            return -1;
        } else {
            var fact = convertInt(operand[0]);
            for var i = convertInt(operand[0]); i > 1; i-- {
                fact *= i - 1
            }
            return fact
        }
    default:
        print("Could not understand entered expression, please try again.")
        return -1
    }
}

func add (x: Int, y: Int) -> Int {
    return x + y;
}

func subtract (x: Int, y: Int) -> Int {
    return x - y;
}

func mulitply (x: Int, y: Int) -> Int {
    return x * y;
}

func divide (x: Int, y: Int) -> Int {
    return x / y;
}

func calculate (x: Int, y: Int, operation: (Int, Int) -> Int) -> Int {
    return operation(x, y)
}

// ------------------- NO MORE METHODS PAST HERE -------------------------

//part 1: simple calc
print("Part 1: Enter an expression separated by returns:")

var firstInp = input()
let operand = input()
var secondInp = input()

if (firstInp.containsString(".") || secondInp.containsString(".")) { // deterimine if float or int
    let x = convertFloat(firstInp)
    let y = convertFloat(secondInp)
    let result = parseOperandAndCalc(operand, x: x, y: y)
    print("result: \(result)")
} else {
    let x = convertInt(firstInp)
    let y = convertInt(secondInp)
    let result = parseOperandAndCalc(operand, x: x, y: y)
    print("result: \(result)")
}


//part 2: multi-operand
print("Part 2: Enter an expression separated by spaces then count, avg, or fact:")
let digits = input().componentsSeparatedByString(" ")
let secondResult = parseMultiOperandAndCalc(digits)
print(secondResult)





