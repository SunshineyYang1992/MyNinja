//
//  YXYPoopWall.swift
//  Nimble Ninja
//
//  Created by Sunshine Yang on 7/29/15.
//  Copyright (c) 2015 SunshineYang. All rights reserved.
//

import UIKit
import SpriteKit


class YXYPoopWall: SKSpriteNode {
	
	let WALL_WIDTH:CGFloat = 50.0
	let WALL_HEIGHT:CGFloat = 50.0
	let WALL_COLOR = UIColor.blackColor()
	
	init() {
		let size = CGSize(width: WALL_WIDTH, height: WALL_HEIGHT)
		let texture = SKTexture(imageNamed: "POOP.png")
		super.init(texture: texture, color: WALL_COLOR, size: size )
		loadPhysicBodyWithSize(size)
		movingWall()
	}
	
	func loadPhysicBodyWithSize(size: CGSize) {
		physicsBody = SKPhysicsBody(rectangleOfSize: size)
		physicsBody?.categoryBitMask = wallCategory
		physicsBody?.affectedByGravity = false
	}
	
	func movingWall() {
		let moveLeft = SKAction.moveByX(-kDefaltXToMovePerSec, y: 0, duration: 1)
		runAction(SKAction.repeatActionForever(moveLeft))
	}
	func stopMoving() {
		removeAllActions()
	}

	required init?(coder aDecoder: NSCoder) {
	    fatalError("init(coder:) has not been implemented")
	}
	
}
