//
//  SceneOne.swift
//  SpriteKitTest
//
//  Created by Oleksandr Smakhtin on 24/08/2023.
//

import UIKit
import SpriteKit

class SceneOne: SKScene {
    
    
    //MARK: - Nodes
    private lazy var ballNode: SKNode = {
        let node = SKShapeNode(ellipseOf: CGSize(width: 25, height: 25))
        node.position = CGPoint(x: size.width / 2, y: size.height / 2)
        node.fillColor = .red
        node.physicsBody = SKPhysicsBody(circleOfRadius: 25)
        node.physicsBody?.affectedByGravity = true
        node.physicsBody?.isDynamic = true
        node.physicsBody?.restitution = 0.8
        return node
    }()
    
    private lazy var groundNode: SKNode = {
        let node = SKSpriteNode(color: .green, size: CGSize(width: size.width, height: 20))
        node.position = CGPoint(x: size.width / 2, y: node.size.height / 2)
        node.physicsBody = SKPhysicsBody(rectangleOf: node.size)
        node.physicsBody?.isDynamic = false
        return node
    }()
    
    
    //MARK: - init
    override init(size: CGSize) {
        super.init(size: size)
        // bg color
        backgroundColor = .black
        // settings
        physicsWorld.gravity = CGVector(dx: 0, dy: -9.8)
        // add childs
        addChilds()
    }

    //MARK: - Add childs
    private func addChilds() {
        addChild(ballNode)
        addChild(groundNode)
    }
    
    //MARK: - Add random node
    private func addRandom(to position: CGPoint) {
        let colors: [UIColor] = [.gray, .blue, .cyan, .orange, .green, .yellow]
        let random = Int.random(in: 0...2)
        var node = SKShapeNode()
        
        switch random {
        case 0:
            node = SKShapeNode(ellipseOf:CGSize(width: 50, height: 50))
            node.physicsBody = SKPhysicsBody(circleOfRadius: 50)
        case 1:
            node = SKShapeNode(rectOf: CGSize(width: 50, height: 50))
            node.physicsBody = SKPhysicsBody(rectangleOf: node.frame.size)
        case 2:
            let path = CGMutablePath()
            path.move(to: CGPoint(x: -50, y: -50))
            path.addLine(to: CGPoint(x: 50, y: -50))
            path.addLine(to: CGPoint(x: 0, y: 50))
            path.closeSubpath()
            
            node = SKShapeNode(path: path)
            node.physicsBody = SKPhysicsBody(polygonFrom: path)
        default:
            return
        }
        
        node.fillColor = colors.randomElement()!
        node.physicsBody?.affectedByGravity = true
        node.physicsBody?.isDynamic = true
        node.physicsBody?.restitution = 0.8
        
        node.position = position
        addChild(node)
        
    }
    
    //MARK: - Required init
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}


//MARK: - Touches
extension SceneOne {
    // touches began
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        
        addRandom(to: location)
        
        guard ballNode.contains(location) else { return }
        ballNode.physicsBody?.affectedByGravity = false
        ballNode.physicsBody?.isDynamic = false
    }
    
    // touches moved
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        ballNode.position = location
    }
    
    // touches ended
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        ballNode.physicsBody?.affectedByGravity = true
        ballNode.physicsBody?.isDynamic = true
    }
    
}
