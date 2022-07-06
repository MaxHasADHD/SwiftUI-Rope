//
//  RopeModel.swift
//  Physics
//
//  Created by Maximilian Litteral on 7/6/22.
//

import Foundation
import SwiftUI

class RopeModel: ObservableObject {
    
    var rope: Rope {
        didSet {
            objectWillChange.send()
        }
    }
    private let ropeLength: CGFloat
    
    private var ropes: [Rope]
    
    @Published var control: CGPoint
    
    init(a1: CGPoint, a2: CGPoint, ropeLength: CGFloat = 400) {
        let r = Rope(length: ropeLength, a1: a1, a2: a2)
        self.rope = r
        self.ropeLength = ropeLength
        self.ropes = [r]
        self.control = r.control
    }
    
    func updateAnchors(a1: CGPoint, a2: CGPoint) {
        rope = Rope(length: ropeLength, a1: a1, a2: a2)
        ropes.append(rope)
        ropes = Array(ropes[..<2])
    }
    
    // new control = old control + velocity * time interval
    func applyVelocity(_ v: CGVector, interval: TimeInterval) {
        var p = ropes.last?.control ?? rope.control
        p += v
        p *= interval
        control = p
    }
}
