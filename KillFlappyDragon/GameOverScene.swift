//
//  GameOverScene.swift
//  KillFlappyDragon
//
//  Created by Jean Sik on 2017/10/15.
//  Copyright © 2017 Jean Sik. All rights reserved.
//

import SpriteKit

class GameOverScene: SKScene {
    var textTop: CGFloat = 0
    var winTheGame: Bool = false
    var flappyDragon: String = "0"
    
    override init(size: CGSize) {
        super.init(size: size)
        textTop = self.size.height/2 + 80
        self.backgroundColor = .white
        let gameOverLabel = SKLabelNode(fontNamed: "Arial")
        gameOverLabel.text = "Game Over"
        gameOverLabel.fontSize = 40
        gameOverLabel.fontColor = .black
        gameOverLabel.position = CGPoint(x: self.size.width/2,y: textTop)
        self.addChild(gameOverLabel)
    }
    
    override func didMove(to view: SKView) {
        let resultLabel = SKLabelNode(fontNamed: "Arial")
        resultLabel.text = (winTheGame ? "Congratulations! You won!" : "Oh no! You lost :(")
        resultLabel.fontSize = 30
        resultLabel.fontColor = .red
        resultLabel.position = CGPoint(x: self.size.width/2,y: textTop - 40)
        self.addChild(resultLabel)
        
        if (!winTheGame) {
            let countLabel = SKLabelNode(fontNamed: "Arial")
            countLabel.text = "You killed " + self.flappyDragon + " Flappy Dragons"
            countLabel.fontSize = 30
            countLabel.fontColor = .black
            countLabel.position = CGPoint(x: self.size.width/2,y: self.textTop - 100)
            self.addChild(countLabel)
        }
        
        let replayButton = SKLabelNode(fontNamed: "Arial")
        replayButton.text = "Play Again"
        replayButton.fontSize = 30
        replayButton.fontColor = .blue
        replayButton.position = CGPoint(x: self.size.width/2, y: self.textTop - 200)
        replayButton.name = "replay"
        self.addChild(replayButton)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches {
            let location = touch.location(in: self)
            let node = self.nodes(at: location).first
            if node?.name == "replay" {
                let reveal : SKTransition = SKTransition.flipHorizontal(withDuration: 0.5)
                let scene = GameScene(size: self.view!.bounds.size)
                scene.scaleMode = .aspectFill
                self.view?.presentScene(scene, transition: reveal)
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
