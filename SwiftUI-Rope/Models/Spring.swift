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
    
    private var velocity = CGVector.zero

    /// Calculates a point for a given time to simulate a spring
    /// - Parameters:
    ///   - position: Position from control (red dot)
    ///   - anchor: The point that the control is "connected" to.
    ///   - stiffness: The extent to which an object resists deformation in response to an applied force
    ///   - mass: The density and type of atoms in any given object
    ///   - damping: The force that slows down and eventually stops an oscillation by dissipating energy
    /// - Returns: The end point of the spring for a given time.
    func calculatePosition(
        position: CGPoint,
        anchor: CGPoint,
        timeInterval: TimeInterval = 0.2,
        gravity: CGFloat = 9.8,
        stiffness: CGFloat = 10,
        mass: CGFloat = 8,
        damping: CGFloat = 5
    ) -> CGPoint {
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
