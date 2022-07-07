//
//  Spring.swift
//  Physics
//
//  Created by Maximilian Litteral on 7/6/22.
//

import Foundation
import SwiftUI

// https://blog.maximeheckel.com/posts/the-physics-behind-spring-animations/
// force = negative stiffness * displacement
// acceleration = negative stiffness * displacement / mass
// velocity = old velocity + acceleration * time interval
// position = old position + velocity * time interval
// damping Force = negative damping * velocity

// Would the velocity be on the control in the first place? Not the control points?
struct Spring {
    
    /* Spring Length, set to 1 for simplicity */
    let length: CGFloat = 1

    ///
    /// - Parameters:
    ///   - position: Position from control
    ///   - stiffness: ?
    ///   - mass: ?
    /// - Returns: New position from control
    func calculatePosition(position: CGPoint, velocity: CGVector, timeInterval: TimeInterval, stiffness: CGFloat = 10, mass: CGFloat = 8, damping: CGFloat = 10) -> CGPoint {
        /* Object position and velocity. */
        var x: CGPoint = position
//        var v: CGVector = velocity
        
        /* Spring stiffness, in kg / s^2 */
        let k: CGFloat = -stiffness
        
        /* Damping constant, in kg / s */
        let d = CGPoint(x: -damping * velocity.dx, y: -damping * velocity.dy)
        
        let xSpringForce = k * (x.x - length)
        let ySpringForce = k * (x.y - length)
        
        let ax = (xSpringForce + d.x) / mass
        let ay = (ySpringForce + d.y) / mass
        // TODO: Pass new vector out as well?
//        v += a * timeInterval
        x = CGPoint(x: ax, y: ay)
        x += velocity
        x *= timeInterval
        return x
    }
}

// Based on https://twitter.com/t3ssel8r/status/1470039981502922752
struct Rope {
    // Length of rope, unchanging.
    let length: CGFloat
    
    let a1: CGPoint
    let a2: CGPoint
    
    // Slack in the rope (red dot)
    var slack: CGFloat {
        // Distance cannot be > the length of the rope
        let slack = length - distance(a1, a2)
        return max(min(length, slack), 0)
    }
    
    // Midpoint
    var ropeCenter: CGPoint {
        midpoint(a1, a2)
    }
    
    // Control (grey dot)
    var control: CGPoint {
        var control = ropeCenter
        control.y += slack
        return control
    }
}
