//
//  RopeView.swift
//  Physics
//
//  Created by Maximilian Litteral on 7/5/22.
//

import SwiftUI

// Rope is done using a `interpolatingSpring` and animated data with a group of points

struct RopeShape: Shape {
    let rope: Rope
    
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: rope.a1)
            path.addQuadCurve(to: rope.a2, control: rope.control)
        }
    }
}

let now = Date.now

struct RopeView: View, Animatable {
    
    let anchor1: CGPoint
    var anchor2: CGPoint
    let date: Date
    
    var animatableData: AnimatablePair<CGFloat, CGFloat> {
        get { AnimatablePair(anchor2.x, anchor2.y) }
        set {
            anchor2 = CGPoint(x: newValue.first, y: newValue.second)
        }
    }
    
    var body: some View {
        Canvas { context, size in
            let rope = Rope(length: 400, a1: anchor1, a2: anchor2)
            let path = RopeShape(rope: rope).path(in: .zero)

            // Visual
            context.stroke(path,
                           with: .color(.white),
                           style: StrokeStyle(lineWidth: 4, lineCap: .round, lineJoin: .round))
            context.stroke(path,
                           with: .palette([.color(.red), .color(.white), .color(.red), .color(.white)]),
                           style: StrokeStyle(lineWidth: 4, lineCap: .round, lineJoin: .round, dash: [8, 14], dashPhase: date.timeIntervalSince(now) * -50))
            // Debug info
//            context.drawLayer { ctx in
//                var rect = CGRect(x: rope.ropeCenter.x - 10, y: rope.ropeCenter.y - 10, width: 20, height: 20)
//                ctx.fill(Circle().path(in: rect), with: .color(.green))
//                rect.origin.y += rope.slack
//                ctx.fill(Circle().path(in: rect), with: .color(.red))
//            }
            
        }
        .shadow(color: .black.opacity(0.1), radius: 1, x: 0, y: 10)
        .allowsHitTesting(false)
    }
    
    func generateNodes() -> [Node] {
        let totalNodes = 50
        var currentPoint = anchor1
        
        let xDist = anchor2.x - anchor1.x
        let xStep = xDist / CGFloat(totalNodes)
        
        let yDist = anchor2.y - anchor1.y
        let yStep = yDist / CGFloat(totalNodes)

        let step = CGPoint(x: xStep, y: yStep)
        
        var nodes: [Node] = (0..<totalNodes).map { i in
            currentPoint += step
            return Node(position: currentPoint, locked: false)
        }
        nodes.insert(Node(position: anchor1, locked: true), at: 0)
        nodes.append(Node(position: anchor2, locked: true))
        return nodes
    }
    
    func update(nodes: [Node]) {
        
        for node in nodes {
            guard !node.locked else {
                continue
            }
            let prevPos = node.position
            node.position += node.position - node.previousPosition
            node.position += CGPoint(x: 0, y: 0.196)
            node.previousPosition = prevPos
        }
        
//        for stick in sticks {
//            let stickCenter = stick.center
//            let stickDirection = stick.direction
//
//            if !stick.nodeA.locked {
//                stick.nodeA.position = stickCenter + stickDirection * stick.length / 2
//                stick.nodeA.position = CGPoint(x: stick.nodeA.position.x.clamped(to: 5...1195), y: stick.nodeA.position.y.clamped(to: 5...895))
//            }
//
//            if !stick.nodeB.locked {
//                stick.nodeB.position = stickCenter - stickDirection * stick.length / 2
//
//                stick.nodeB.position = CGPoint(x: stick.nodeB.position.x.clamped(to: 5...1195), y: stick.nodeB.position.y.clamped(to: 5...895))
//            }
//        }
    }
}

struct RopeView_Previews: PreviewProvider {
    static var previews: some View {
        RopeView(anchor1: CGPoint(x: 0, y: 0), anchor2: CGPoint(x: 50, y: 100), date: .now)
    }
}
