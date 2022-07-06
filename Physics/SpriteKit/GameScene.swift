//
//  GameScene.swift
//  Physics
//
//  Created by Maximilian Litteral on 7/6/22.
//

import SpriteKit
import GameplayKit

extension SKNode {
    var positionInScene:CGPoint? {
        if let scene = scene, let parent = parent {
            return parent.convert(position, to:scene)
        } else {
            return nil
        }
    }
}

class GameScene: SKScene {
    
    // MARK: - Properties
    
    var anchor1: CGPoint!
    var anchor2: CGPoint!
    
    private var rope = RopeNode(with: 5, and: SKTexture(imageNamed: "chain_ring"))
    private var head: SKSpriteNode!
    private var tail: SKSpriteNode!
    
    var nodePositions: [CGPoint] {
        rope.nodePositions.map { convertPoint(toView: $0) }
    }
    
    // MARK: - Lifecycle
    
    override func didMove(to view: SKView) {
        /*let attachmentNode = SKSpriteNode(color: .red, size: CGSize(width: 20, height: 20))
        attachmentNode.physicsBody = SKPhysicsBody(rectangleOf: attachmentNode.size)
        attachmentNode.physicsBody?.affectedByGravity = false
        attachmentNode.physicsBody?.isDynamic = false
        attachmentNode.position = convertPoint(fromView: anchor1)
        head = attachmentNode
        addChild(attachmentNode)
        
//        let tailNode = SKSpriteNode(color: .red, size: CGSize(width: 20, height: 20))
//        tailNode.physicsBody = SKPhysicsBody(rectangleOf: attachmentNode.size)
//        tailNode.physicsBody?.affectedByGravity = false
//        tailNode.physicsBody?.isDynamic = false
//        tailNode.position = convertPoint(fromView: anchor2)
//        tail = tailNode
//        addChild(tailNode)
        
        rope.attach(to: attachmentNode)
        rope.attach(anchor: SKTexture())
        
        
//                let engeNode = SKNode()
//                engeNode.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
//                self.addChild(engeNode)
        
        */
        
        setUpPhysics()
        setupVines()
    }
    
    private func setUpPhysics() {
//        physicsWorld.contactDelegate = self
//        self.yScale = -1 // flip coordinates?
        anchorPoint = CGPoint(x: 1, y: 0)
        
        physicsWorld.gravity = CGVector(dx: 0.0, dy: -9.8)
        physicsWorld.speed = 1.0
    }
    
    private func setupVines() {
        tail = SKSpriteNode(color: .red, size: CGSize(width: 20, height: 20))
        tail.physicsBody = SKPhysicsBody(rectangleOf: tail.size)
        tail.physicsBody?.affectedByGravity = false
        tail.physicsBody?.isDynamic = true
        tail.position = convertAnchor(anchor2)
        addChild(tail)
        
        let vine = VineNode(length: 20, anchorPoint: CGPoint(x: 0, y: 500), name: "Rope 1")
        vine.addToScene(self)
        vine.attachToPrize(tail)
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
//        head.position = convertAnchor(anchor1)
        tail.position = convertAnchor(anchor2)
    }
    
    func convertAnchor(_ anchor: CGPoint) -> CGPoint {
        CGPoint(x: anchor.x - 500, y:  500 - anchor.y)
    }
    
    func convertPointForView(_ anchor: CGPoint) -> CGPoint {
        CGPoint(x: 500 - anchor.x, y:  500 + anchor.y)
    }
}

extension SKNode {
    func drawBorder(color: NSColor, width: CGFloat) {
        let shapeNode = SKShapeNode(rect: frame)
        shapeNode.fillColor = .clear
        shapeNode.strokeColor = color
        shapeNode.lineWidth = width
        addChild(shapeNode)
    }
}
