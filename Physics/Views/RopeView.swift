//
//  RopeView.swift
//  Physics
//
//  Created by Maximilian Litteral on 7/5/22.
//

import SwiftUI

// Rope is done using a `interpolatingSpring` and animated data with a group of points

struct RopeShape: Shape {
    let ropeModel: RopeModel
    
    func path(in rect: CGRect) -> Path {
        Path { path in
            let rope = ropeModel.rope
            path.move(to: rope.a1)
            path.addQuadCurve(to: rope.a2, control: ropeModel.control)
        }
    }
}

let now = Date.now

struct RopeView: View, Animatable {
    
    @ObservedObject var ropeModel: RopeModel
    
    var body: some View {
        Canvas { context, size in
            let path = RopeShape(ropeModel: ropeModel).path(in: .zero)

            // Visual
            context.stroke(path,
                           with: .color(.white),
                           style: StrokeStyle(lineWidth: 4, lineCap: .round, lineJoin: .round))
//            context.stroke(path,
//                           with: .palette([.color(.red), .color(.white), .color(.red), .color(.white)]),
//                           style: StrokeStyle(lineWidth: 4, lineCap: .round, lineJoin: .round, dash: [8, 14], dashPhase: date.timeIntervalSince(now) * -50))
            // Debug info
            let rope = ropeModel.rope
            context.drawLayer { ctx in
                let debugSize = CGSize(width: 20, height: 20)
                // Center
                var rect = CGRect(origin: rope.ropeCenter - 10, size: debugSize)
                ctx.fill(Circle().path(in: rect), with: .color(.green))
                
                // Control
                rect = CGRect(origin: rope.control - 10, size: debugSize)
                ctx.fill(Circle().path(in: rect), with: .color(.red))
                
                // Velocity applied
                rect = CGRect(origin: ropeModel.control - 10, size: debugSize)
                ctx.fill(Circle().path(in: rect), with: .color(.purple))
            }
            
        }
        .shadow(color: .black.opacity(0.1), radius: 1, x: 0, y: 10)
        .allowsHitTesting(false)
    }
}

//struct RopeView_Previews: PreviewProvider {
//    static var previews: some View {
//        RopeView(anchor1: CGPoint(x: 0, y: 0), anchor2: CGPoint(x: 50, y: 100), date: .now, velocity: .zero)
//    }
//}
