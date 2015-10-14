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

// turns strings into ints
func convertInt(incoming:String) -> Int {
    return NSNumberFormatter().numberFromString(incoming)!.integerValue
}

// turns strings into floats
func convertFloat(incoming:String) -> Float {
    return NSNumberFormatter().numberFromString(incoming)!.floatValue
}

// returns int value the calculated result for single operand operations
func parseOperandAndCalc(operand: String, x:Int, y:Int) -> Int {
    return Int(parseOperandAndCalc(operand, x: Float(x), y: Float(y)))
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

func multiply (x: Int, y: Int) -> Int {
    return x * y;
}

func divide (x: Int, y: Int) -> Int {
    return x / y;
}

func mod (x: Int, y: Int) -> Int {
    return x / y;
}

func calculate (operation: (Int, Int) -> Int, x: Int, y: Int) -> Int {
    return operation(x, y)
}

// sums all the elements in an array and returns the result
func addAllElementsInArray(x: [Int]) -> Int {
    var sum = 0
    for var i = 0; i < x.count; i++ {
        sum += x[i]
    }
    return sum
}

// multiplys all the elemnts in an array and returns the result
func multiplyAllElementsInArray(x: [Int]) -> Int {
    var result = 1
    for var i = 0; i < x.count; i++ {
        result *= x[i]
    }
    return result
}

// returns the number of elements in an array
func arrayCount(x: [Int]) -> Int {
    return x.count
}

// returns the average all the elements in an array
func averageElementsInArray(x: [Int]) -> Int {
    return addAllElementsInArray(x) / arrayCount(x);
}

// generic array function
func calculateArray(operation: ([Int]) -> Int, x: [Int]) -> Int {
    return operation(x)
}

func addPoints(pointOne: (Int, Int), pointTwo: (Int, Int)) -> (Int, Int) {
    return (pointOne.0 + pointTwo.0, pointOne.1 + pointTwo.1)
}

func addPoints(pointOne: (Double, Double), pointTwo: (Double, Double)) -> (Double, Double) {
    return (pointOne.0 + pointTwo.0, pointOne.1 + pointTwo.1)
}

func subtractPoints(pointOne: (Int, Int), pointTwo: (Int, Int)) -> (Int, Int) {
    return (pointOne.0 - pointTwo.0, pointOne.1 - pointTwo.1)
}

func subtractPoints(pointOne: (Double, Double), pointTwo: (Double, Double)) -> (Double, Double) {
    return (pointOne.0 - pointTwo.0, pointOne.1 - pointTwo.1)
}

func addDictionaries(pointOne: Dictionary<String, Int>, pointTwo: Dictionary<String, Int>) -> Dictionary<String, Int> {
    return ["x": (pointOne["x"]! + pointTwo["x"]!), "y": (pointOne["y"]! + pointTwo["y"]!)]
}

func addDictionaries(pointOne: Dictionary<String, Double>, pointTwo: Dictionary<String, Double>) -> Dictionary<String, Double> {
    return ["x": (pointOne["x"]! + pointTwo["x"]!), "y": (pointOne["y"]! + pointTwo["y"]!)]
}

func subtractDictionaries(pointOne: Dictionary<String, Int>, pointTwo: Dictionary<String, Int>) -> Dictionary<String, Int> {
    return ["x": (pointOne["x"]! - pointTwo["x"]!), "y": (pointOne["y"]! - pointTwo["y"]!)]
}

func subtractDictionaries(pointOne: Dictionary<String, Double>, pointTwo: Dictionary<String, Double>) -> Dictionary<String, Double> {
    return ["x": (pointOne["x"]! - pointTwo["x"]!), "y": (pointOne["y"]! - pointTwo["y"]!)]
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


//part 3: array addition and multiplication
let xArray = [1, 2, 3, 4, 5]
let yArray = [-5, 16, 22, 0, 2]
print("Adding all the elements int the array \(xArray)")
print("Result = \(calculateArray(addAllElementsInArray, x:xArray))")
print("Multiplying all the elements in \(yArray)")
print("Result = \(calculateArray(multiplyAllElementsInArray, x:yArray))")
print("Counting all the elements int the array \(xArray)")
print("Result = \(calculateArray(arrayCount, x:xArray))")
print("Averaging all the elements in \(yArray)")
print("Result = \(calculateArray(averageElementsInArray, x:yArray))")

//part 4: tuple and dictionary addition and subtraction
let pointOne = (1, 5)
let pointTwo = (7, -2)
let dictOne = ["x": 4, "y": 12]
let dictTwo = ["x": 5, "y": 10]

print("Adding the two points \(pointOne) and \(pointTwo)")
print("Result = \(addPoints(pointOne, pointTwo: pointTwo))")
print("Subtracting the two points \(pointOne) and \(pointTwo)")
print("Result = \(subtractPoints(pointOne, pointTwo: pointTwo))")

print("Adding the two dictionaries \(pointOne) and \(pointTwo)")
print("Result = \(addPoints(pointOne, pointTwo: pointTwo))")
print("Subtracting the two dictionaries \(pointOne) and \(pointTwo)")
print("Result = \(subtractPoints(pointOne, pointTwo: pointTwo))")