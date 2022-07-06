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
            PlugView()
                .frame(width: 25, height: 25)
                .position(plugTwo.position)
                .gesture(
                    dragPlugTwo
                )

            TimelineView(.animation(minimumInterval: 0.01, paused: false)) { context in
                RopeView(anchor1: plugOne.position, anchor2: plugTwo.position, date: context.date)
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
