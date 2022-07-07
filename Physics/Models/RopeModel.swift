//
//  RopeModel.swift
//  Physics
//
//  Created by Maximilian Litteral on 7/6/22.
//

import Foundation
import SwiftUI

class RopeModel: ObservableObject {
    
    var rope: Rope
    private let ropeLength: CGFloat
    private let spring = Spring()
    
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
        control = spring.calculatePosition(position: control, anchor: rope.control, timeInterval: 0.2)
    }
    
    func updateControl(interval: TimeInterval) {
        control = spring.calculatePosition(position: control, anchor: rope.control, timeInterval: 0.2)
    }
}
