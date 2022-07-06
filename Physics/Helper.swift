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

func midpoint(_ a: CGPoint, _ b: CGPoint) -> CGPoint {
    let x = (a.x + b.x) / 2
    let y = (a.y + b.y) / 2
    return CGPoint(x: x, y: y)
}

func velocity(_ a: CGPoint, _ b: CGPoint, _ t1: Date, _ t2: Date) -> CGVector {
    let dx = a.x - b.x
    let dy = a.y - b.y
    var dt = t1.timeIntervalSince1970 - t2.timeIntervalSince1970
    if dt < 0 {
        dt = 1 / dt
    }
    let vx = dx / dt
    let vy = dy / dt
    return CGVector(dx: vx, dy: vy)
}

func +=(_ lhs: inout CGPoint, _ rhs: CGPoint) {
    lhs.x += rhs.x
    lhs.y += rhs.y
}

func +=(_ lhs: inout CGPoint, _ rhs: CGVector) {
    lhs.x += rhs.dx
    lhs.y += rhs.dy
}

func *=(_ lhs: inout CGPoint, _ rhs: TimeInterval) {
    lhs.x *= rhs
    lhs.y *= rhs
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

func -(_ lhs: CGPoint, _ rhs: CGFloat) -> CGPoint {
    return CGPoint(x: lhs.x - rhs, y: lhs.y - rhs)
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
