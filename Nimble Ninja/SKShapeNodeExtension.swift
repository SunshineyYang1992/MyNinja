//
//  File.swift
//  Nimble Ninja
//
//  Created by Sunshine Yang on 8/1/15.
//  Copyright (c) 2015 SunshineYang. All rights reserved.
//

import Foundation
import SpriteKit

extension SKShapeNode {
	func setTiledFillTexture(imageName: String, tileSize: CGSize) {
		let targetDimension = max(self.frame.size.width, self.frame.size.height)
		let targetSize = CGSizeMake(targetDimension, targetDimension)
		let targetRef = UIImage(named: imageName)!.CGImage
		
		UIGraphicsBeginImageContext(targetSize)
		let contextRef = UIGraphicsGetCurrentContext()
		CGContextDrawTiledImage(contextRef, CGRect(origin: CGPointZero, size: tileSize), targetRef)
		let tiledTexture = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()
		
		self.fillTexture = SKTexture(image: tiledTexture)
	}
}