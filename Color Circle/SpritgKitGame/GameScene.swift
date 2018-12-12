//
//  GameScene.swift
//  SpritgKitGame
//
//  Created by Zhonghao Wang on 2018/11/21.
//  Copyright © 2018年 Zhonghao Wang. All rights reserved.
//

import SpriteKit
import GameplayKit


enum GameStatus {
    case idle //
    case running //running
    case over //game over
    case win //win
}

enum ballColors {
    static let colors = [
        NSColor(red:254/255, green: 254/255, blue: 75/255, alpha: 1.0),
        NSColor(red:248/255, green: 187/255, blue: 44/255, alpha: 1.0),
        NSColor(red:249/255, green: 152/255, blue: 39/255, alpha: 1.0),
        NSColor(red:250/255, green: 84/255,  blue: 34/255, alpha: 1.0),
        //(251,43,36)
        NSColor(red:251/255, green: 43/255,  blue: 36/255, alpha: 1.0),
        //(165,29,76)
        NSColor(red:165/255, green: 29/255,  blue: 76/255, alpha: 1.0),
        //(133,23,172)
        NSColor(red:133/255, green: 23/255,  blue: 172/255, alpha: 1.0),
        //(61,20,161)
        NSColor(red:61/255, green: 20/255,  blue: 161/255, alpha: 1.0),
        //(16,79,241)
        NSColor(red:16/255, green: 79/255,  blue: 241/255, alpha: 1.0),
        //(24,147,204)
        NSColor(red:24/255, green: 147/255,  blue: 204/255, alpha: 1.0),
        //(104,174,59)
        NSColor(red:104/255, green: 174/255,  blue: 59/255, alpha: 1.0),
        //(208,232,64)
        NSColor(red:208/255, green: 232/255,  blue: 64/255, alpha: 1.0)
    ]
}

enum SwitchState: Int{
    case one, two, three, four, five, six, seven, eight, nine, ten, eve, twe
}

enum Physics {
    static let none: UInt32 = 0
    static let ballCategory: UInt32 = 0x1
    static let switchCategory: UInt32 = 0x1 << 1
}


class GameScene: SKScene {
    
    var colorSwitch: SKSpriteNode!
    var switchState = SwitchState.one
    var currentColorIndex: Int?
    
    var score: NSInteger = 0
    
    lazy var scoreLabelNode:SKLabelNode = {
        let label = SKLabelNode(fontNamed: "MarkerFelt-Wide")
        label.zPosition = 100
        label.text = "0"
        return label
    }()
    
    lazy var winGame:SKLabelNode = {
        let label = SKLabelNode(fontNamed: "Chalkduster")
        label.zPosition = 100
        label.text = "Congratulation! Win the game"
        return label
    }()
    
    lazy var gameOverLabel:SKLabelNode = {
        let label = SKLabelNode(fontNamed: "Chalkduster")
        label.zPosition = 100
        label.fontColor = NSColor.red
        label.text = "Game Over!"
        return label
    }()
    
    lazy var pushContibue:SKLabelNode = {
        let label = SKLabelNode(fontNamed: "MarkerFelt-Wide")
        label.zPosition = 100
        label.fontSize = 15
        label.fontColor = NSColor.white
        label.text = "Press enter to continue!"
        return label
    }()
    
    lazy var levelOfGame:SKLabelNode = {
        let label = SKLabelNode(fontNamed: "MarkerFelt-Wide")
        label.zPosition = 100
        label.fontSize = 30
        label.fontColor = NSColor.white
        return label
    }()
    
    var gameStatus:GameStatus = .idle
    
    var ball :SKSpriteNode!
    
    var coinSound = SKAudioNode(fileNamed: "coin.mp3")
    var boomSound = SKAudioNode(fileNamed: "boom.mp3")
    var liangSound = SKAudioNode(fileNamed: "wang.mp3")
    
    var welcomeScene: Welcome!
    
    
    override func didMove(to view: SKView) {
        
        // Get label node from scene and store it for use later
        layoutScence()
        idleStatus()
    }
    
    func idleStatus() {
        
        gameStatus = .idle
        
        gameOverLabel.removeFromParent()
        
        scoreLabelNode.removeFromParent()
        
        winGame.removeFromParent()
        
        pushContibue.removeFromParent()
        
        levelOfGame.removeFromParent()
        
        setupPhysics()
        
        spawnBall()
        
        ball.physicsBody?.isDynamic = false
        
        coinSound.isPositional = false
        coinSound.autoplayLooped = false
        addChild(coinSound)
        
        boomSound.isPositional = false
        boomSound.autoplayLooped = false
        addChild(boomSound)
        
//        liangSound.isPositional = false
//        liangSound.autoplayLooped = false
//
//        addChild(liangSound)
        
    }
    
    func runningStatus() {
        gameStatus = .running
        
        score = 0
        scoreLabelNode.text = String(score)
        scoreLabelNode.position = CGPoint(x: frame.midX, y: frame.height*2/3)
        levelOfGame.position = CGPoint(x: frame.midX/5, y: frame.minY)
        addChild(scoreLabelNode)
        addChild(levelOfGame)
        levelOfGame.text = "level 1"
        ball.physicsBody?.isDynamic = true
        
    }
    
    func setupPhysics(){
        physicsWorld.gravity = CGVector(dx: 0.0, dy: -0.5)
        physicsWorld.contactDelegate = self
    }
    
    func layoutScence(){
        backgroundColor = NSColor(red: 44/255, green: 62/255, blue: 80/255, alpha: 1.0)
        colorSwitch = SKSpriteNode(imageNamed: "colorCircle")
        colorSwitch.size = CGSize(width: frame.size.width/5, height: frame.size.width/5)
        colorSwitch.position = CGPoint(x: frame.midX, y: frame.minY+colorSwitch.size.height)
        colorSwitch.physicsBody = SKPhysicsBody(circleOfRadius: colorSwitch.size.width/2)
        colorSwitch.physicsBody?.categoryBitMask = Physics.switchCategory
        colorSwitch.physicsBody?.isDynamic = false
        addChild(colorSwitch)
        
    }
    
    func spawnBall(){
        //levelOfGame.removeFromParent()
        currentColorIndex = Int(arc4random_uniform(UInt32(11)))
        //currentColorIndex = 7
        ball = SKSpriteNode(texture: SKTexture(imageNamed: "ball"), color:ballColors.colors[currentColorIndex!],size:CGSize(width: 32, height: 32))
        ball.colorBlendFactor = 1
        ball.name = "ball"
        ball.position = CGPoint(x:frame.midX, y: frame.maxY)
        ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width/2)
        ball.physicsBody?.categoryBitMask = Physics.ballCategory
        ball.physicsBody?.contactTestBitMask = Physics.switchCategory
        ball.physicsBody?.collisionBitMask = Physics.none
        addChild(ball)
    }
    
    func RightTurnWheel(){
        if let newState = SwitchState(rawValue: switchState.rawValue + 1){
            switchState = newState
        }else{
            switchState = .one
        }
        
        colorSwitch.run(SKAction.rotate(byAngle: .pi/6, duration: 0.25))
    }
    
    func LeftTurnWheel(){
        if switchState.rawValue == 0{
            
            if let newState = SwitchState(rawValue: 11){
                switchState = newState
            }
            
        }else{
            
            if let newState = SwitchState(rawValue: switchState.rawValue - 1){
                switchState = newState
            }else{
                switchState = .one
            }
        }
        
        
        colorSwitch.run(SKAction.rotate(byAngle: -.pi/6, duration: 0.25))
    }
    
    func gameOver(){
        gameStatus = .over
        
        addChild(gameOverLabel)
        gameOverLabel.position = CGPoint(x: frame.midX, y: frame.midY)
        
        addChild(pushContibue)
        pushContibue.position = CGPoint(x: frame.midX, y: frame.midY - 20)
        
        let moveUp = SKAction.moveBy(x: 0.0, y: 200, duration: 0.5)
        let fade = SKAction.fadeOut(withDuration: 0.25)
        let sequence = SKAction.sequence([moveUp, fade])
        self.run(moveUp, completion: {
            let transition = SKTransition.flipVertical(withDuration: 1.0)
            self.view?.presentScene(self.welcomeScene, transition: transition)
        })
        
        print("Game Over")
    }
    
    func gameWin(){
        gameStatus = .win
        
        addChild(winGame)
        
        winGame.position = CGPoint(x: frame.midX, y: frame.midY)
        
        let moveUp = SKAction.moveBy(x: 0.0, y: 200, duration: 0.5)
        let fade = SKAction.fadeOut(withDuration: 0.25)
        let sequence = SKAction.sequence([moveUp, fade])
        self.run(moveUp, completion: {
            let transition = SKTransition.flipVertical(withDuration: 1.0)
            self.view?.presentScene(self.welcomeScene, transition: transition)
        })
        
        print("Game Win")
    
    }
    
    override func keyDown(with event: NSEvent) {
        switch gameStatus {
            case .idle:
                if(event.keyCode == 36){
                    runningStatus()
                    print("start running")
                }
                break
            case .running:
                if(event.keyCode == 124){
                    RightTurnWheel()
                }
                if(event.keyCode == 123){
                    LeftTurnWheel()
                }
                break
            case .over:
                if(event.keyCode == 36){
                    idleStatus()
                    print(" re-start")
                }
                break
            case .win:
                idleStatus()
                break
            
        }
    }
   
}

extension GameScene: SKPhysicsContactDelegate{
    
    func didBegin(_ contact: SKPhysicsContact) {
        let contactMask = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        
        if contactMask == Physics.ballCategory | Physics.switchCategory{
            if let ball = contact.bodyA.node?.name == "ball" ? contact.bodyA.node as? SKSpriteNode : contact.bodyB.node as? SKSpriteNode{
                if currentColorIndex == switchState.rawValue{
                    print("Correct!")
                    score += 1
                    scoreLabelNode.text = String(score)
                    if(score>=2){
                        physicsWorld.gravity = CGVector(dx: 0.0, dy: -2)
                        physicsWorld.contactDelegate = self
                        levelOfGame.text = "level 2"
                    }
                    if(score>=4){
                        physicsWorld.gravity = CGVector(dx: 0.0, dy: -3)
                        physicsWorld.contactDelegate = self
                        levelOfGame.text = "level 3"
                    }
                    if(score>=5){
                        physicsWorld.gravity = CGVector(dx: 0.0, dy: -5)
                        physicsWorld.contactDelegate = self
                        levelOfGame.text = "level 4"
                    }
                    coinSound.run(SKAction.play())
                    ball.run(SKAction.fadeOut(withDuration: 0.25), completion: {
                        ball.removeFromParent()
                        self.spawnBall()
                    })
                }else{
                    boomSound.run(SKAction.play())
                    //liangSound.run(SKAction.play())
                    
                    gameOver()
                }
            }
            
            if score >= 8{
                ball.removeFromParent()
                gameWin()
            }
        }
    }
}
