//
//  YXYCloudGenerator.swift
//  Nimble Ninja
//
//  Created by Sunshine Yang on 7/28/15.
//  Copyright (c) 2015 SunshineYang. All rights reserved.
//

import UIKit
import SpriteKit

class YXYCloudGenerator: SKSpriteNode {
	
	let CLOUD_WIDTH:CGFloat = 125.0
	let CLOUD_HEIGHT: CGFloat = 55.0
	
	var generateTimer:NSTimer!
	
	func populateCloud(num: Int) {
		
		for var i = 0; i < num; i++ {
			let cloud = YXYCloud(size: CGSize(width: CLOUD_WIDTH, height: CLOUD_HEIGHT))
			
			let x = CGFloat(arc4random_uniform(UInt32(size.width))) - size.width/2
			let y = CGFloat(arc4random_uniform(UInt32(size.height))) - size.height/2
			cloud.position = CGPoint(x: x, y: y)
			cloud.zPosition = -1
			addChild(cloud)
		}
	}
	func startGeneratingWithTimer(seconds:NSTimeInterval) {
		generateTimer = NSTimer.scheduledTimerWithTimeInterval(seconds, target: self, selector: "generateCloud", userInfo: nil, repeats: true)
	}
	func stopGenerating() {
		generateTimer.invalidate()
	}
	func generateCloud() {
		let x = size.width/2 + CLOUD_WIDTH/2
		let y = CGFloat(arc4random_uniform(UInt32(size.height))) - size.height/2
		let cloud = YXYCloud(size: CGSize(width: CLOUD_WIDTH, height: CLOUD_HEIGHT))
		cloud.position = CGPoint(x: x, y: y)
		cloud.zPosition = -1
		addChild(cloud)
	}
	func removeCloud() {
		let fadeOut = SKAction.fadeAlphaTo(0, duration: 0.5)
		runAction(fadeOut)
		removeAllChildren()
	}
}
