//
//  RopeNode.swift
//  Physics
//
//  Created by Maximilian Litteral on 7/6/22.
//

import SpriteKit

class RopeNode: SKNode {
    
    // MARK: - Properties
    
    private var ropes = [SpriteRopeNode]()
    
    var head: SpriteRopeNode? {
        get {
            return ropes.first
        }
    }
    
    var tail: SpriteRopeNode? {
        get {
            return ropes.last
        }
    }
    
    var nodePositions: [CGPoint] {
        ropes.dropFirst().dropLast().compactMap { $0.positionInScene }
    }
    
    // MARK: - Initializers
    
    init(with length: CGFloat, and texture: SKTexture) {
        super.init()
        
        let num = Int(ceil(length))
        
        for index in 0...num {
            let floatIndex = -CGFloat(index)
            let node = SpriteRopeNode(nodeTexture: texture)
            node.position.y = floatIndex * node.size.height
            
            addChild(node)
            ropes.append(node)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    
    func attach(to node: SKNode) {
        guard let attachmentBody = node.physicsBody, let scene = node.scene, ropes.count > 0, let parent = node.parent, let head = head?.physicsBody else {
            return
        }
        let midx = node.frame.midX
        let midy = node.frame.midY
        let point = CGPoint(x: midx, y: midy)
        
        let attachmentPoint = scene.convert(point, from: parent)
        let joint = SKPhysicsJointPin.joint(withBodyA: attachmentBody, bodyB: head, anchor: attachmentPoint)
        node.addChild(self)
        
        let world = scene.physicsWorld
        world.add(joint)
        constructPhysics(in: world)
    }
    
    func attach(anchor textureRepresentation: SKTexture) {
        guard let tailPosition = tail?.position, let unwrappedTail = tail, let scene = scene else {
            return
        }
        let spriteRopeNode = SpriteRopeNode(nodeTexture: textureRepresentation)
        //        spriteRopeNode.anchorPoint = CGPoint(x: 0.5, y: 1.0)
        spriteRopeNode.position = CGPoint(x: tailPosition.x, y: unwrappedTail.frame.midY)
        spriteRopeNode.physicsBody = SKPhysicsBody(circleOfRadius: spriteRopeNode.size.height / 2)
        spriteRopeNode.physicsBody?.mass = 0.5
        
        scene.addChild(spriteRopeNode)
        ropes.append(spriteRopeNode)
        
        let world = scene.physicsWorld
        constructPhysics(in: world)
    }
    
    // MARK: - Private methods
    
    private func constructPhysics(in world: SKPhysicsWorld) {
        guard let scene = scene else {
            return
        }
        
        for index in 0..<ropes.count - 1 {
            let nodeA = ropes[index]
            let nodeB = ropes[index + 1]
            
            guard let parentA = nodeA.parent, let physicsBodyA = nodeA.physicsBody, let physicsBodyB = nodeB.physicsBody else {
                continue
            }
            
            let midx = nodeA.frame.midX
            let midy = nodeA.frame.midY
            let point = CGPoint(x: midx, y: midy)
            let attachmentPoint = scene.convert(point, from: parentA)
            
            let joint = SKPhysicsJointPin.joint(withBodyA: physicsBodyA, bodyB: physicsBodyB, anchor: attachmentPoint)
            joint.shouldEnableLimits = true
            joint.lowerAngleLimit = 0
            joint.upperAngleLimit = 0
            world.add(joint)
        }
    }
    
}

class SpriteRopeNode: SKSpriteNode {
    
    // MARK: - Initializers
    
    init(nodeTexture: SKTexture) {
        super.init(texture: nil, color: .blue, size: CGSize(width: 20, height: 20))
//        super.init(texture: nodeTexture, color: .blue, size: nodeTexture.size())
        
        self.anchorPoint = CGPoint(x: 0.5, y: 1.0)
        self.physicsBody = SKPhysicsBody(rectangleOf: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
