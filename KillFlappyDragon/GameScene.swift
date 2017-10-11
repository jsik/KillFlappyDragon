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
    let MAX_DRAGON = 10
    
    var plane:SKSpriteNode!
    var moveUpPlane: SKAction!
    var moveDownPlane: SKAction!
    var countFlappyDragon = 0
    var lastFlappyDragon: TimeInterval = 0
    
    override func didMove(to view: SKView) {
        self.backgroundColor = .white
        self.addBg()
        self.addPlane()
        self.addFlappyDragon()
    }

    func addBg() {
        let bg = SKSpriteNode(imageNamed: "Background")
        bg.position = CGPoint(x: 0, y: 0)
        bg.anchorPoint = CGPoint(x: 0, y: 0)
        bg.name = "background"
        
        self.addChild(bg)
    }
    
    func addPlane(){
        plane = SKSpriteNode(imageNamed: "FlyPlane")
        plane.name = "plane"
        plane.position = CGPoint(x: 100, y: 100)
        plane.setScale(0.25)
        
        moveUpPlane = SKAction.moveBy(x: 0, y: 30, duration: 0.2)
        moveDownPlane = SKAction.moveBy(x: 0, y: -30, duration: 0.2)
            
        self.addChild(plane)
    }
    
    func addFlappyDragon() {
        let flappydragon = SKSpriteNode(imageNamed: "FlappyDragon")
        flappydragon.position = CGPoint(x: self.frame.size.width - 20, y: CGFloat(arc4random_uniform(300)))
        flappydragon.setScale(0.05)
        flappydragon.name = "flappydragon"
        self.addChild(flappydragon)
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
        for _: AnyObject in touches {
            if plane.position.y < 300 {
                plane.run(moveUpPlane)
            } else if plane.position.y > 50 {
                plane.run(moveDownPlane)
            }
        }

    }

    func moveFlappyDragon() {
        self.enumerateChildNodes(withName: "flappydragon", using: {(node, stop) -> Void in
            if let flappydragon = node as? SKSpriteNode {
                flappydragon.position = CGPoint(x: flappydragon.position.x - 5.0, y: flappydragon.position.y)
                
                if flappydragon.position.x < 0 {
                    flappydragon.removeFromParent()
                    self.countFlappyDragon -= 1
                }
            }
        })
    }

    override func update(_ currentTime: TimeInterval) {
        self.moveFlappyDragon()
        if (self.countFlappyDragon < self.MAX_DRAGON && self.lastFlappyDragon < currentTime - 1 ) {
            self.countFlappyDragon += 1
            self.lastFlappyDragon = currentTime + 1
            self.addFlappyDragon()
        }
    }
}
