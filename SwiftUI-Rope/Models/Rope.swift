//
//  Rope.swift
//  SwiftUI-Rope
//
//  Created by Maximilian Litteral on 7/8/22.
//

import Foundation

// Based on https://twitter.com/t3ssel8r/status/1470039981502922752
class Rope: ObservableObject {
    @Published var length: CGFloat
    
    @Published var a1: CGPoint
    @Published var a2: CGPoint
    
    private let spring = Spring()
    
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
    
    @Published var springPoint: CGPoint
    @Published var gravity: CGFloat = 9.8
    @Published var mass: CGFloat = 8
    @Published var stiffness: CGFloat = 10
    @Published var damping: CGFloat = 4
    
    init(length: CGFloat = 400, a1: CGPoint, a2: CGPoint) {
        self.length = length
        self.a1 = a1
        self.a2 = a2
        self.springPoint = .zero
        self.springPoint = control
    }
    
    func updateAnchors(a1: CGPoint, a2: CGPoint) {
        self.a1 = a1
        self.a2 = a2
    }
    
    func updateSpring(interval: TimeInterval) {
        springPoint = spring.calculatePosition(position: springPoint,
                                               anchor: control,
                                               timeInterval: 0.2,
                                               gravity: gravity,
                                               stiffness: stiffness,
                                               mass: mass,
                                               damping: damping)
    }
}
