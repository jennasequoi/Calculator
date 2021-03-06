//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Jenna Brown on 02/08/2017.
//  Copyright © 2017 Jbro. All rights reserved.
//

import Foundation

class CalculatorBrain {
    
    private var accumulator = 0.0
    private var memory = 0.0
    var description = ""
    var isPartialResult = false;
    
    func setOperand(operand: Double){
        accumulator = operand
        addToDescription(symbol: String(operand))
        print(description)
    }
    
    private var operations: Dictionary<String, Operation> = [
        "π" : Operation.Constant(Double.pi),
        "e" : Operation.Constant(M_E),
        "√" : Operation.UnaryOperation(sqrt),
        "cos" : Operation.UnaryOperation(cos),
        "sin" : Operation.UnaryOperation(sin),
        "tan" : Operation.UnaryOperation(tan),
        "m+" : Operation.MemoryAdd,
        "m-" : Operation.MemoryMinus,
        "mr" : Operation.MemoryRecall,
        "mc" : Operation.MemoryClear,
        "c" : Operation.Clear,
        "×" : Operation.BinaryOperation({ $0 * $1 }),
        "÷" : Operation.BinaryOperation({ $0 / $1 }),
        "+" : Operation.BinaryOperation({ $0 + $1 }),
        "-" : Operation.BinaryOperation({ $0 - $1 }),
        "=" : Operation.Equals
    ]
    
    private enum Operation {
        case Constant(Double)
        case UnaryOperation((Double) -> Double)
        case BinaryOperation((Double,Double) -> Double)
        case Equals
        case Clear
        case MemoryAdd
        case MemoryMinus
        case MemoryRecall
        case MemoryClear
    }
    
    func performOperation(symbol: String){
        if let operation = operations[symbol] {
            switch operation {
            case .Constant(let value): accumulator = value
            case .UnaryOperation(let function): accumulator = function(accumulator)
            case .BinaryOperation(let function):
                executePendingBinaryOperation()
                pending = PendingBinaryOperationInfo(binaryFunction:  function, firstOperand: accumulator)
                isPartialResult = true
            case .Equals: executePendingBinaryOperation()
            case .Clear: resetAll()
            case .MemoryAdd: memory += accumulator
            case .MemoryMinus: memory -= accumulator
            case .MemoryRecall: accumulator = memory
            case .MemoryClear: memory = 0.0
            }
            addToDescription(symbol: symbol)
        }
        
    }
    
    private func executePendingBinaryOperation()
    {
        if pending != nil {
            accumulator = pending!.binaryFunction(pending!.firstOperand, accumulator)
            pending = nil
            isPartialResult = false
        }
    }
    
    private func resetAll() {
        accumulator = 0.0
        pending = nil
        description = " "
        isPartialResult = false
    }
    
    private func addToDescription(symbol: String){
        if symbol != "=" && symbol != "." && symbol != "c"{
            description = self.description + " " + symbol
            print(self.description)
        }
    }
    
    private var pending: PendingBinaryOperationInfo?
    
    private struct PendingBinaryOperationInfo {
        var binaryFunction: (Double, Double) -> Double
        var firstOperand: Double
    }
    
    var result: Double {
        get{
            print(description)
            return accumulator
       
        }
    }
}
