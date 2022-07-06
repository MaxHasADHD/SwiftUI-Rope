//
//  ContentView.swift
//  Physics
//
//  Created by Maximilian Litteral on 7/5/22.
//

import SwiftUI
import SpriteKit

struct ContentView: View {
    
    @StateObject var plugOne = Plug(position: CGPoint(x: 50, y: 50))
    
    @StateObject var plugTwo = Plug(position: CGPoint(x: 100, y: 100))
    
    @State private var previousDragValue: DragGesture.Value?
    @State private var velocity: CGVector?
    
    @State private var ropeModel = RopeModel(a1: CGPoint(x: 50, y: 50), a2: CGPoint(x: 100, y: 100))
    
    /// https://stackoverflow.com/questions/57222885/calculate-velocity-of-draggesture
    func calcDragVelocity(previousValue: DragGesture.Value, currentValue: DragGesture.Value) -> CGVector? {
        let timeInterval = currentValue.time.timeIntervalSince(previousValue.time)
        
        let diffXInTimeInterval = Double(currentValue.translation.width - previousValue.translation.width)
        let diffYInTimeInterval = Double(currentValue.translation.height - previousValue.translation.height)
        
        let velocityX = diffXInTimeInterval / timeInterval
        let velocityY = diffYInTimeInterval / timeInterval
        
        let v = CGVector(dx: velocityX, dy: velocityY)
        ropeModel.applyVelocity(v, interval: timeInterval)
        return v
    }
    
    var body: some View {
        let dragPlugOne = DragGesture()
            .onChanged { value in
                plugOne.move(by: value.translation)
                
                if let previousValue = previousDragValue {
                    // calc velocity using currentValue and previousValue
                    velocity = calcDragVelocity(previousValue: previousValue, currentValue: value)
                }
                // save previous value
                previousDragValue = value
            }
            .onEnded { value in
                plugOne.endMoving()
                previousDragValue = nil
            }
        
        let dragPlugTwo = DragGesture()
            .onChanged { value in
                if let previousValue = previousDragValue {
                    // calc velocity using currentValue and previousValue
                    velocity = calcDragVelocity(previousValue: previousValue, currentValue: value)
                    print("Velocity: ", velocity)
                }
                // save previous value
                previousDragValue = value
                
                plugTwo.move(by: value.translation)
            }
            .onEnded { value in
                plugTwo.endMoving()
                previousDragValue = nil
            }
        
        ZStack {
            
            PlugView()
                .frame(width: 25, height: 25)
                .position(plugOne.position)
                .gesture(
                    dragPlugOne
                )
                .onChange(of: plugOne.position) { newValue in
                    ropeModel.updateAnchors(a1: newValue, a2: plugTwo.position)
                }
            PlugView()
                .frame(width: 25, height: 25)
                .position(plugTwo.position)
                .gesture(
                    dragPlugTwo
                )
                .onChange(of: plugTwo.position) { newValue in
                    ropeModel.updateAnchors(a1: plugOne.position, a2: newValue)
                }

            TimelineView(.animation(minimumInterval: 0.01, paused: false)) { context in
                RopeView(ropeModel: ropeModel)
            }
        }
        .frame(width: 500, height: 500)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .frame(width: 500, height: 500, alignment: .center)
    }
}
