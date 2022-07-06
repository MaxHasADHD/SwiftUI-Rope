//
//  AnimatableVector.swift
//  Physics
//
//  Created by Maximilian Litteral on 7/6/22.
//

import SwiftUI
import enum Accelerate.vDSP
//import enum Accelerate.vForce

struct AnimatableVector: VectorArithmetic {
    static var zero = AnimatableVector(values: [0.0])
    
    static func + (lhs: AnimatableVector, rhs: AnimatableVector) -> AnimatableVector {
        let count = min(lhs.values.count, rhs.values.count)
        return AnimatableVector(values: vDSP.add(lhs.values[0..<count], rhs.values[0..<count]))
    }
    
    static func += (lhs: inout AnimatableVector, rhs: AnimatableVector) {
        let count = min(lhs.values.count, rhs.values.count)
        vDSP.add(lhs.values[0..<count], rhs.values[0..<count], result: &lhs.values[0..<count])
    }
    
    static func - (lhs: AnimatableVector, rhs: AnimatableVector) -> AnimatableVector {
        let count = min(lhs.values.count, rhs.values.count)
        return AnimatableVector(values: vDSP.subtract(lhs.values[0..<count], rhs.values[0..<count]))
    }
    
    static func -= (lhs: inout AnimatableVector, rhs: AnimatableVector) {
        let count = min(lhs.values.count, rhs.values.count)
        vDSP.subtract(lhs.values[0..<count], rhs.values[0..<count], result: &lhs.values[0..<count])
    }
    
    var values: [Double]
    
    mutating func scale(by rhs: Double) {
        values = vDSP.multiply(rhs, values)
    }
    
    var magnitudeSquared: Double {
        vDSP.sum(vDSP.multiply(values, values))
    }
}
