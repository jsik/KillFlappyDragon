//
//  GameOverScene.swift
//  KillFlappyDragon
//
//  Created by Jean Sik on 2017/10/15.
//  Copyright © 2017 Jean Sik. All rights reserved.
//

import SpriteKit

class GameOverScene: SKScene {
    var winTheGame: Bool = false
    var killedFlappyDragon: Int = 0
    
    override init(size: CGSize) {
        super.init(size: size)
        
        self.backgroundColor = .white
        let textTop = self.size.height/2 - 80
        let gameOverLabel = SKLabelNode(fontNamed: "Arial")
        gameOverLabel.text = "Game Over"
        gameOverLabel.fontSize = 40
        gameOverLabel.fontColor = .black
        gameOverLabel.position = CGPoint(x: self.size.width/2,y: textTop)
        self.addChild(gameOverLabel)
        
        let resultLabel = SKLabelNode(fontNamed: "Arial")
        resultLabel.text = (winTheGame ? "You won the game! " : "Sorry! You lost! ")
        resultLabel.fontSize = 30
        resultLabel.fontColor = .black
        resultLabel.position = CGPoint(x: self.size.width/2,y: textTop - 35)
        self.addChild(resultLabel)
        
        if (!winTheGame) {
            print(self.killedFlappyDragon)
//            let countLabel = SKLabelNode(fontNamed: "Arial")
//            resultLabel.text =
//            resultLabel.fontSize = 30
//            resultLabel.fontColor = .black
//            resultLabel.position = CGPoint(x: self.size.width/2,y: self.textTop - 35)
//            self.addChild(resultLabel)
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
