//
//  RopeView.swift
// SwiftUI-Rope
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
            path.addQuadCurve(to: rope.a2, control: rope.springPoint)
        }
    }
}

let now = Date.now

struct RopeView: View, Animatable {
    
    @ObservedObject var rope: Rope
    let date: Date
    
    var showDebugInfo: Bool
    
    var body: some View {
        Canvas { context, size in
            let path = RopeShape(rope: rope).path(in: .zero)

            // Visual
            context.stroke(path,
                           with: .color(.white),
                           style: StrokeStyle(lineWidth: 4, lineCap: .round, lineJoin: .round))
            context.stroke(path,
                           with: .palette([.color(.red), .color(.white), .color(.red), .color(.white)]),
                           style: StrokeStyle(lineWidth: 4, lineCap: .round, lineJoin: .round, dash: [8, 14], dashPhase: date.timeIntervalSince(now) * -50))
            
            // Debug info
            if showDebugInfo {
                context.drawLayer { ctx in
                    let debugSize = CGSize(width: 20, height: 20)
                    // Center
                    var rect = CGRect(origin: rope.ropeCenter - 10, size: debugSize)
                    ctx.fill(Circle().path(in: rect), with: .color(.green))
                    
                    // Control
                    rect = CGRect(origin: rope.control - 10, size: debugSize)
                    ctx.fill(Circle().path(in: rect), with: .color(.red))
                    
                    // Velocity applied
                    rect = CGRect(origin: rope.springPoint - 10, size: debugSize)
                    ctx.fill(Circle().path(in: rect), with: .color(.purple))
                }
            }
        }
        .shadow(color: .black.opacity(0.1), radius: 1, x: 0, y: 10)
        .allowsHitTesting(false)
    }
}
