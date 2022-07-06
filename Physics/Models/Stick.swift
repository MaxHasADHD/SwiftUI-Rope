//
//  Stick.swift
//  Physics
//
//  Created by Maximilian Litteral on 7/5/22.
//

import Foundation

class Stick: Identifiable {
    let id  = UUID()
    
    let nodeA: Node
    let nodeB: Node
    
    var length: CGFloat
    var center: CGPoint {
        return (nodeA.position + nodeB.position) / 2
    }
    var direction: CGPoint {
        return (nodeA.position - nodeB.position).normalized()
    }
    
    init(nodeA: Node, nodeB: Node) {
        self.nodeA = nodeA
        self.nodeB = nodeB
        self.length = distance(nodeA.position, nodeB.position)
    }
}
