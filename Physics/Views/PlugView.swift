//
//  PlugView.swift
//  Physics
//
//  Created by Maximilian Litteral on 7/5/22.
//

import SwiftUI

struct PlugView: View {
    
    var body: some View {
        GeometryReader { geo in
            Circle()
                .fill(Color(nsColor: NSColor.darkGray))
                .overlay(
                    Circle()
                        .inset(by: geo.size.width * 0.1)
                        .fill(Color(nsColor: NSColor.lightGray))
                )
        }
    }
}

struct PlugView_Previews: PreviewProvider {
    static var previews: some View {
        PlugView()
            .frame(width: 50, height: 50)
    }
}
