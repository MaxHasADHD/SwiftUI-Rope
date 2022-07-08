//
//  Spring.swift
// SwiftUI-Rope
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

class Spring {

    let gravity: CGFloat = 9.8
    
    private var velocity = CGVector.zero

    /// Calculates a point for a given time to simulate a spring
    /// - Parameters:
    ///   - position: Position from control (red dot)
    ///   - stiffness: K
    ///   - mass: M
    ///   - damping: D
    /// - Returns: The end point of the spring for a given time.
    func calculatePosition(position: CGPoint, anchor: CGPoint, timeInterval: TimeInterval = 0.2, stiffness: CGFloat = 10, mass: CGFloat = 8, damping: CGFloat = 3) -> CGPoint {
        /* Spring stiffness, in kg / s^2 */
        let k: CGFloat = -stiffness
        
        /* Damping constant, in kg / s */
        let dx = damping * velocity.dx
        let dy = damping * velocity.dy
        
        // Spring force
        let xSpringForce = k * (position.x - anchor.x)
        let ySpringForce = k * (position.y - anchor.y)
        
        // Force
        let forceX = xSpringForce - dx
        let forceY = ySpringForce + mass * gravity - dy
        
        // Accelleration
        let ax = forceX / mass
        let ay = forceY / mass
        
        // New velocity
        let vx = velocity.dx + ax * timeInterval
        let vy = velocity.dy + ay * timeInterval
        velocity = CGVector(dx: vx, dy: vy)
        
        // New position
        let positionX = position.x + vx * timeInterval
        let positionY = position.y + vy * timeInterval
        
        return CGPoint(x: positionX, y: positionY)
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
