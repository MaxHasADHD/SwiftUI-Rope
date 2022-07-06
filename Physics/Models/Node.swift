//
//  Node.swift
//  Physics
//
//  Created by Maximilian Litteral on 7/5/22.
//

import Foundation

class Node: Identifiable {
    let id = UUID()
    
    var position: CGPoint
    var previousPosition: CGPoint
    var locked: Bool
    
    init(position: CGPoint, locked: Bool) {
        self.position = position
        self.locked = locked
        self.previousPosition = .zero
    }
}
