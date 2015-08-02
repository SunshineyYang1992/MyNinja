//
//  YXYPoopWallGenerator.swift
//  Nimble Ninja
//
//  Created by Sunshine Yang on 7/29/15.
//  Copyright (c) 2015 SunshineYang. All rights reserved.
//

import UIKit
import SpriteKit


class YXYPoopWallGenerator: SKSpriteNode {
	
	var generateTimer:NSTimer!
	// Keep track walls
	var walls = [YXYPoopWall]()
	
	// Track points
	var wallTrackers = [YXYPoopWall]()
	
	
	func startGeneratingWithTimer(seconds:NSTimeInterval) {
		generateTimer = NSTimer.scheduledTimerWithTimeInterval(seconds, target: self, selector: "generateWall", userInfo: nil, repeats: true)
	}
	func stopGeneratingWalls() {
		generateTimer.invalidate()
	}
	func generateWall() {
		
		var scale: CGFloat
		
		let random = arc4random_uniform(2)
		if random == 0 {
			scale = -1.0
		}else {
			scale = 1.0
		}
		
		let wall = YXYPoopWall()
		wall.position.x = size.width/2 + wall.size.width/2
		wall.position.y = scale * (kYXYGroundHeight/2 + wall.size.height/2)
		walls.append(wall)
		wallTrackers.append(wall)
		addChild(wall)
	}
	func stopWalls() {
		stopGeneratingWalls()
		
		for wall in walls {
			wall.stopMoving()
		}
		
	}
}
