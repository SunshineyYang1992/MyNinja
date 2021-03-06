//
//  GameViewController.swift
//  Nimble Ninja
//
//  Created by Sunshine Yang on 7/26/15.
//  Copyright (c) 2015 SunshineYang. All rights reserved.
//

import UIKit
import SpriteKit



class GameViewController: UIViewController {
	
	var scene: GameScene!
	

    override func viewDidLoad() {
		super.viewDidLoad()
		
		// Configure view
		let skView = view as! SKView
		skView.multipleTouchEnabled = false
		
		// Create ,congifure and present the scene
		scene = GameScene(size: skView.bounds.size)
		scene.scaleMode = .AspectFill
		skView.presentScene(scene)
		
		
	}

    override func shouldAutorotate() -> Bool {
        return true
    }

    override func supportedInterfaceOrientations() -> Int {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return Int(UIInterfaceOrientationMask.AllButUpsideDown.rawValue)
        } else {
            return Int(UIInterfaceOrientationMask.All.rawValue)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
