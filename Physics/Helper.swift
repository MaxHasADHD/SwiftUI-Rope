//
//  Helper.swift
//  Physics
//
//  Created by Maximilian Litteral on 7/5/22.
//

import Foundation
import SwiftUI

func distance(_ a: CGPoint, _ b: CGPoint) -> CGFloat {
    let xDist = a.x - b.x
    let YDist = a.y - b.y
    return CGFloat(sqrt(xDist * xDist + YDist * YDist))
}

func +=(_ lhs: inout CGPoint, _ rhs: CGPoint) {
    lhs.x += rhs.x
    lhs.y += rhs.y
}

func -(_ lhs: CGPoint, _ rhs: CGPoint) -> CGPoint {
    return CGPoint(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
}

func +(_ lhs: CGPoint, _ rhs: CGPoint) -> CGPoint {
    return CGPoint(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
}

func +(_ lhs: CGPoint, _ rhs: CGFloat) -> CGPoint {
    return CGPoint(x: lhs.x + rhs, y: lhs.y + rhs)
}

func /(_ lhs: CGPoint, _ rhs: CGFloat) -> CGPoint {
    return CGPoint(x: lhs.x / rhs, y: lhs.y / rhs)
}

func *(_ lhs: CGPoint, _ rhs: CGFloat) -> CGPoint {
    return CGPoint(x: lhs.x * rhs, y: lhs.y * rhs)
}

extension CGPoint {
    
    func length() -> CGFloat {
        return sqrt(x*x + y*y)
    }
    
    func normalized() -> CGPoint {
        let length = length()
        return length>0 ? self / length : .zero
    }
    
}

