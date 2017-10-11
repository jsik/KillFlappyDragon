//
//  GameScene.swift
//  KillFlappyDragon
//
//  Created by Jean Sik on 2017/10/10.
//  Copyright © 2017 Jean Sik. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var plane:SKSpriteNode!
    
    override func didMove(to view: SKView) {
        self.backgroundColor = .white
        self.addBg()
        self.addPlane()
    }

    func addBg() {
        for i in 0..<2 {
            let bg = SKSpriteNode(imageNamed: "Background")
            bg.position = CGPoint(x: i * Int(bg.size.width), y: 0)
            bg.anchorPoint = CGPoint(x: 0, y: 0)
            bg.name = "background"
            
            self.addChild(bg)
        }
    }
    
    func addPlane(){
        plane = SKSpriteNode(imageNamed: "FlyPlane")
        plane.name = "plane"
        plane.position = CGPoint(x: 120, y: 160)
        plane.setScale(0.25)
        self.addChild(plane)
    }
    
    func touchDown(atPoint pos : CGPoint) {
//        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
//            n.position = pos
//            n.strokeColor = SKColor.green
//            self.addChild(n)
//        }
    }
    
    func touchMoved(toPoint pos : CGPoint) {
//        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
//            n.position = pos
//            n.strokeColor = SKColor.blue
//            self.addChild(n)
//        }
    }
    
    func touchUp(atPoint pos : CGPoint) {
//        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
//            n.position = pos
//            n.strokeColor = SKColor.red
//            self.addChild(n)
//        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        if let label = self.label {
//            label.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
//        }
//        
//        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        //for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        //for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
//        self.enumerateChildNodes(withName: "background", using: {(node, stop) -> Void in
//            if let bg = node as? SKSpriteNode {
//                bg.position = CGPoint(x: bg.position.x - 3.0, y: bg.position.y)
//                
//                if bg.position.x <= -bg.size.width {
//                    bg.position = CGPoint(x: bg.position.x + bg.size.width * 2, y: bg.position.y)
//                }
//            }
//        })
    }
}
