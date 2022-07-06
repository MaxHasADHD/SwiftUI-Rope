//
//  Spring.swift
//  Physics
//
//  Created by Maximilian Litteral on 7/6/22.
//

import Foundation
import SwiftUI

struct Spring: Animatable {
    
    var animatableData: CGFloat {
        get { position }
        set {
            /* Object position and velocity. */
            var x: CGFloat = 2
            var v: CGFloat = 0
            
            /* Spring stiffness, in kg / s^2 */
            let k: CGFloat = -stiffness;
            
            let fSpring = k * (x - length)
            let a = fSpring / mass
            v += a * frameRate
            x += v * frameRate
            position = x
        }
    }
    
    let length: CGFloat = 1
    let mass: CGFloat = 1
    let stiffness: CGFloat = 20
    /* Framerate: we want 60 fps hence the framerate here is at 1/60 */
    let frameRate: CGFloat = 1 / 60
    private(set) var position: CGFloat = 0
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
    
}
