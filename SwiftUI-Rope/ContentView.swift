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
    
    @State private var ropeModel = RopeModel(a1: CGPoint(x: 50, y: 50), a2: CGPoint(x: 100, y: 100))
    
    var body: some View {
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
                RopeView(ropeModel: ropeModel, date: context.date)
                    .onChange(of: context.date) { (newValue: Date) in
                        ropeModel.updateControl(interval: 0.01)
                    }
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
