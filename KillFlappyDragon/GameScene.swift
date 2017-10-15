//
//  GameScene.swift
//  KillFlappyDragon
//
//  Created by Jean Sik on 2017/10/10.
//  Copyright © 2017 Jean Sik. All rights reserved.
//

import SpriteKit
import GameplayKit

struct PhysicsCategory {
    static let None    : UInt32 = 0
    static let All     : UInt32 = UInt32.max
    static let dragon : UInt32 = 0b1  //1
    static let plane   : UInt32 = 0b10 //2
    static let bullet : UInt32 = 0b11 //3
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    let MAX_DRAGON = 10
    
    var plane:SKSpriteNode!
    var moveUpPlane: SKAction!
    var moveDownPlane: SKAction!
    var deadPlane: SKAction!
    
    var countFlappyDragon = 0
    var killedFlappyDragon = 0
    var lastFlappyDragon: TimeInterval = 0
    
    override func didMove(to view: SKView) {
        self.backgroundColor = .white
        self.addBg()
        self.addPlane()
        self.addFlappyDragon()
        physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        physicsWorld.contactDelegate = self
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
        plane.setScale(0.25)
        
        plane.physicsBody = SKPhysicsBody(rectangleOf: plane.size)
        plane.physicsBody?.isDynamic = true
        plane.physicsBody?.categoryBitMask = PhysicsCategory.plane
        plane.physicsBody?.contactTestBitMask = PhysicsCategory.dragon
        plane.physicsBody?.collisionBitMask = PhysicsCategory.None
        
        plane.name = "plane"
        plane.position = CGPoint(x: 100, y: 100)

        moveUpPlane = SKAction.moveBy(x: 0, y: 30, duration: 0.2)
        moveDownPlane = SKAction.moveBy(x: 0, y: -30, duration: 0.2)
        deadPlane = SKAction.moveBy(x: 0, y: -1000, duration: 1)
            
        self.addChild(plane)
    }
    
    func addFlappyDragon() {
        let flappydragon = SKSpriteNode(imageNamed: "FlappyDragon")
        flappydragon.setScale(0.05)
        
        flappydragon.physicsBody = SKPhysicsBody(rectangleOf: flappydragon.size)
        flappydragon.physicsBody?.isDynamic = true
        flappydragon.physicsBody?.categoryBitMask = PhysicsCategory.dragon
        flappydragon.physicsBody?.contactTestBitMask = PhysicsCategory.bullet
        flappydragon.physicsBody?.collisionBitMask = PhysicsCategory.None
        
        flappydragon.name = "flappydragon"
        flappydragon.position = CGPoint(x: self.frame.size.width - 20, y: CGFloat(arc4random_uniform(300)))
        
        self.addChild(flappydragon)
    }
    
    func addProjectile() {
        let projectile = SKSpriteNode(imageNamed: "Bullet")
        projectile.setScale(0.25)
        
        projectile.physicsBody = SKPhysicsBody(rectangleOf: projectile.size)
        projectile.physicsBody?.isDynamic = true
        projectile.physicsBody?.categoryBitMask = PhysicsCategory.bullet
        projectile.physicsBody?.contactTestBitMask = PhysicsCategory.dragon
        projectile.physicsBody?.collisionBitMask = PhysicsCategory.None
        projectile.zPosition = 10
        
        projectile.name = "projectile"
        projectile.position = CGPoint(x: self.plane.position.x, y: self.plane.position.y)
        
        self.addChild(projectile)
    }
    
    func fireProjectile() {
        self.addProjectile()
    }
    
    func touchDown(atPoint pos : CGPoint) {
    }
    
    func touchMoved(toPoint pos : CGPoint) {
    }
    
    func touchUp(atPoint pos : CGPoint) {
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        var dragonBody:SKPhysicsBody
        if (contact.bodyA.categoryBitMask == 2 && contact.bodyB.categoryBitMask == 1) {
            print("Dragon hit plane")
            plane.run(deadPlane)
            //plane.removeFromParent()
        } else if (contact.bodyA.categoryBitMask == 3 && contact.bodyB.categoryBitMask == 1) {
            dragonBody = contact.bodyB
            guard dragonBody.node != nil else { return }
            (dragonBody.node as! SKSpriteNode).removeFromParent()
            killedFlappyDragon += 1
            countFlappyDragon -= 1
            print("Projectile hit Dragon " + String(killedFlappyDragon))
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches {
            let location = touch.location(in: self)
            if location.x > plane.position.x {
                self.fireProjectile()
            }
            if location.y > plane.position.y {
                plane.run(moveUpPlane)
            } else if plane.position.y > 50 {
                plane.run(moveDownPlane)
            }
        }

    }
    
    func moveProjectile() {
        self.enumerateChildNodes(withName: "projectile", using: {(node, stop) -> Void in
            if let projectile = node as? SKSpriteNode {
                projectile.position = CGPoint(x: projectile.position.x + 8.0, y: projectile.position.y)
                
                if projectile.position.x > 10000 {
                    projectile.removeFromParent()
                }
            }
        })
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
        self.moveProjectile()
        if (self.countFlappyDragon < self.MAX_DRAGON && self.lastFlappyDragon < currentTime - 1 ) {
            self.countFlappyDragon += 1
            self.lastFlappyDragon = currentTime + 1
            self.addFlappyDragon()
        }
    }
}
