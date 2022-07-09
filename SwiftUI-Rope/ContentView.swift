//
//  ContentView.swift
// SwiftUI-Rope
//
//  Created by Maximilian Litteral on 7/5/22.
//

import SwiftUI
import SpriteKit

struct ContentView: View {
    
    @StateObject var plugOne = Plug(position: CGPoint(x: 50, y: 50))
    
    @StateObject var plugTwo = Plug(position: CGPoint(x: 100, y: 100))
    
    @StateObject private var ropeModel = Rope(a1: CGPoint(x: 50, y: 50), a2: CGPoint(x: 100, y: 100))
    
    @State private var showDebug = false
    
    var body: some View {
        VStack {
            canvas
            
            VStack(alignment: .leading) {
                Toggle("Debug info", isOn: $showDebug)
                
                Slider(value: $ropeModel.length, in: 200...1000,
                       label: { Text("Rope Length") },
                       minimumValueLabel: { Text("200") },
                       maximumValueLabel: { Text("1000") })
                
                Slider(value: $ropeModel.stiffness, in: 0...30,
                       label: { Text("Stiffness") },
                       minimumValueLabel: { Text("0") },
                       maximumValueLabel: { Text("30") })
                
                Slider(value: $ropeModel.mass, in: 1...30,
                       label: { Text("Mass") },
                       minimumValueLabel: { Text("1") },
                       maximumValueLabel: { Text("30") })
                
                Slider(value: $ropeModel.damping, in: 0...10,
                       label: { Text("Damping") },
                       minimumValueLabel: { Text("0") },
                       maximumValueLabel: { Text("10") })
                
                Slider(value: $ropeModel.gravity, in: 1...30,
                       label: { Text("Gravity") },
                       minimumValueLabel: { Text("1") },
                       maximumValueLabel: { Text("30") })
                
                Button("Reset") {
                    ropeModel.length = 400
                    ropeModel.gravity = 9.8
                    ropeModel.stiffness = 10
                    ropeModel.mass = 8
                    ropeModel.damping = 4
                }
            }
            .padding()
        }
        .frame(minWidth: 500, minHeight: 500)
    }
    
    @ViewBuilder
    var canvas: some View {
        let dragPlugOne = DragGesture()
            .onChanged { value in
                plugOne.move(by: value.translation)
            }
            .onEnded { value in
                plugOne.endMoving()
            }
        
        let dragPlugTwo = DragGesture()
            .onChanged { value in
                plugTwo.move(by: value.translation)
            }
            .onEnded { value in
                plugTwo.endMoving()
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

            // The spring is constantly changing, not just in the moment. TimelineView has a Date interval, I need to use that to calculate the new control
            TimelineView(.animation(minimumInterval: 0.01, paused: false)) { context in
                RopeView(rope: ropeModel, date: context.date, showDebugInfo: showDebug)
                    .onChange(of: context.date) { (newValue: Date) in
                        ropeModel.updateSpring(interval: 0.01)
                    }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .frame(width: 500, height: 500, alignment: .center)
    }
}
