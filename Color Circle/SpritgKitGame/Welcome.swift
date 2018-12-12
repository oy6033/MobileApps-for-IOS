//
//  Welcome.swift
//  SpritgKitGame
//
//  Created by Yangkang Ou 2018/11/21.
//  Copyright © 2018年 Yangkang Ou. All rights reserved.
//

import Cocoa
import SpriteKit



class Welcome: SKScene {
    var gameScene: GameScene!
    
    
    
    override func didMove(to view: SKView){
        backgroundColor = SKColor.blue
        
        let textNode = SKLabelNode(fontNamed: "Futura")
        let textNode8 = SKLabelNode(fontNamed: "Futura")
        let textNode2 = SKLabelNode(fontNamed: "Futura")
        let textNode3 = SKLabelNode(fontNamed: "Futura")
        let textNode4 = SKLabelNode(fontNamed: "Futura")
        let textNode5 = SKLabelNode(fontNamed: "Futura")
        let textNode6 = SKLabelNode(fontNamed: "Futura")
        let textNode7 = SKLabelNode(fontNamed: "Futura")
        
        textNode.text = "Play"
        textNode.fontSize = 100
        textNode.position = CGPoint(x: size.width / 2.0, y: size.height / 2.0)
        
        textNode.color = SKColor.yellow
        textNode.name = "Hello"
        
        
        textNode8.text = "Press enter to begin the game"
        textNode8.fontSize = 30
        textNode8.position = CGPoint(x: size.width / 2.0, y: size.width / 3.5)
        
        textNode8.color = SKColor.white
        textNode8.name = "Hello"
        
        
        
        
        textNode2.text = "Player controls a circle wheel object. Keyboard controls make the circle object move left/right"
        
        textNode2.fontSize = 14
        textNode2.position = CGPoint(x: size.width / 2.0, y: size.height / 3.1)
        
        textNode2.color = SKColor.yellow
        textNode2.name = "Hello"
        
        textNode3.text = "Color of the ball are randomly generated, and ball drops from the top of view with midX and maxY."
        
        textNode3.fontSize = 14
        textNode3.position = CGPoint(x: size.width / 2.0, y: size.height / 3.5)
        
        textNode3.color = SKColor.yellow
        textNode3.name = "Hello"
        
        textNode7.text = "Ball fall down with constant gravity and hit the circle wheel at the bottom of the view."
        
        textNode7.fontSize = 14
        textNode7.position = CGPoint(x: size.width / 2.0, y: size.height / 4.0)
        
        textNode7.color = SKColor.yellow
        textNode7.name = "Hello"
        
        textNode4.text = " If a ball hits the circle wheel with the different color, the game will end."
        
        textNode4.fontSize = 14
        textNode4.position = CGPoint(x: size.width / 2.0, y: size.height / 4.7)
        
        
        textNode4.color = SKColor.yellow
        textNode4.name = "Hello"
        
        textNode6.text = "The player gets 1 points if the ball hits circle wheel with the same color."
        
        textNode6.fontSize = 14
        textNode6.position = CGPoint(x: size.width / 2.0, y: size.height / 5.5)
        
        
        textNode6.color = SKColor.yellow
        textNode6.name = "Hello"
        
        textNode5.text = "When the player reaches 8 points, they win! Return to Intro scene, with a “You Win” congrats message."
        
        textNode5.fontSize = 14
        textNode5.position = CGPoint(x: size.width / 2.0, y: size.height / 6.5)
        
        textNode5.color = SKColor.yellow
        textNode5.name = "Hello"
        
        
        
        addChild(textNode)
        addChild(textNode8)
        addChild(textNode2)
        addChild(textNode3)
        addChild(textNode4)
        addChild(textNode5)
        addChild(textNode6)
        addChild(textNode7)
    }
    
    
    
    override func keyDown(with event: NSEvent) {
        
        //        if let node = childNode(withName: "Hello"){
        //
        //             let moveUp = SKAction.moveBy(x: 0.0, y: 200.0, duration: 0.5)
        //             let fade = SKAction.fadeOut(withDuration: 0.25)
        //             let sequence = SKAction.sequence([moveUp, fade])
        //             node.run(sequence, completion: {
        //                let game = Game(size: self.size)
        
        if(event.keyCode == 36){
            let ross =  GameScene(size: self.size)
            ross.welcomeScene = self
            let transition = SKTransition.flipVertical(withDuration: 1.0)
            self.view?.presentScene(ross, transition: transition)

        }
        
        
        
    }
}

