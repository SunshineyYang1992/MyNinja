//
//  YXYMovingGround.swift
//  Nimble Ninja
//
//  Created by Sunshine Yang on 7/26/15.
//  Copyright (c) 2015 SunshineYang. All rights reserved.
//

import Foundation
import SpriteKit

class YXYMovingGround: SKSpriteNode {
	
	let NUMBERS_OF_SEGMENTS = 20
	let COLOR_ONE = UIColor(red: 88.0/255.0, green: 148.0/255.0, blue: 87.0/255.0, alpha: 1.0)
	let COLOR_TWO = UIColor(red: 120.0/255.0, green: 195.0/255.0, blue: 128.0/255.0, alpha: 1.0)
	
	init(size: CGSize) {
		super.init(texture: nil, color: UIColor.brownColor(), size: CGSize(width: size.width*2, height: size.height))
		anchorPoint = CGPoint(x: 0, y: 0.5)
		
		for var i = 0; i < NUMBERS_OF_SEGMENTS; i++ {
			var segmentColor: UIColor!
			if i % 2 == 0 {
				segmentColor = COLOR_ONE
			}
			else {
				segmentColor = COLOR_TWO
			}
			let segment = SKSpriteNode(color: segmentColor, size: CGSize(width: self.size.width / CGFloat( NUMBERS_OF_SEGMENTS), height: self.size.height))
			segment.anchorPoint = CGPoint(x: 0, y: 0.5)
			segment.position = CGPoint(x: segment.size.width * CGFloat(i), y: 0)
			addChild(segment)
			
		}
		
	}

	required init?(coder aDecoder: NSCoder) {
	    fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: Moving ground
	func start() {
		
		let adjustDuration = NSTimeInterval(frame.size.width / kDefaltXToMovePerSec)
		let movingLeft = SKAction.moveByX(-frame.size.width / 2, y: 0, duration: adjustDuration/2)
		let resetPosition = SKAction.moveToX(0, duration: 0)
		
		let movingSequence = SKAction.sequence([movingLeft,resetPosition])
		runAction(SKAction.repeatActionForever(movingSequence), completion: nil)
		
//		runAction(movingSequence, completion: { () -> Void in
//			self.start()
//		})
	}
	func stop() {
		removeAllActions()
	}
}
