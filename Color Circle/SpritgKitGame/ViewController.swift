//
//  ViewController.swift
//  SpritgKitGame
//
//  Created by Zhonghao Wang on 2018/11/21.
//  Copyright © 2018年 Zhonghao Wang. All rights reserved.
//

import Cocoa
import SpriteKit
import GameplayKit

class ViewController: NSViewController {

    @IBOutlet var skView: SKView!
    
    var welcomeScene: Welcome!
    var gameScene: GameScene!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        welcomeScene = Welcome(size: view.frame.size)
        gameScene = GameScene(size: view.bounds.size)
        
        if let view = self.skView {
            // Set the scale mode to scale to fit the window
            //scene.scaleMode = .aspectFill
                
            // Present the scene
            view.presentScene(welcomeScene)
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            
            view.showsNodeCount = true
        }
    }
}

