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

func -(_ lhs: CGPoint, _ rhs: CGFloat) -> CGPoint {
    return CGPoint(x: lhs.x - rhs, y: lhs.y - rhs)
}

