//
//  RopeView.swift
//  Physics
//
//  Created by Maximilian Litteral on 7/5/22.
//

import SwiftUI

private struct Rope: Shape {
    let anchor1: CGPoint
    let anchor2: CGPoint
    
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: anchor1)
//            path.addLines([anchor1, anchor2])
            path.addLine(to: anchor2)
        }
    }
}

let now = Date.now

struct RopeView: View {
    
    let anchor1: CGPoint
    let anchor2: CGPoint
    var nodePositions: [CGPoint]
    let date: Date
    
    var body: some View {
        Canvas { context, size in
//            let nodes = generateNodes()
//            update(nodes: nodes)
            
            let path = Path { path in
                path.move(to: anchor1)
                for node in nodePositions {
//                    path.addLine(to: node.position)
                    path.addLine(to: node)
                }
//                path.move(to: anchor2)
            }
            context.stroke(path,
                           with: .color(.white),
                           style: StrokeStyle(lineWidth: 4, lineCap: .round, lineJoin: .round))
            context.stroke(path,
                           with: .palette([.color(.red), .color(.white), .color(.red), .color(.white)]),
                           style: StrokeStyle(lineWidth: 4, lineCap: .round, lineJoin: .round, dash: [8, 14], dashPhase: date.timeIntervalSince(now)*50))
        }
        .shadow(color: .black.opacity(0.1), radius: 1, x: 0, y: 10)
        .animation(.linear(duration: 1).speed(50), value: date)
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
        RopeView(anchor1: CGPoint(x: 0, y: 0), anchor2: CGPoint(x: 50, y: 100), nodePositions: [], date: .now)
    }
}
