//
//  YXYCloud.swift
//  Nimble Ninja
//
//  Created by Sunshine Yang on 7/29/15.
//  Copyright (c) 2015 SunshineYang. All rights reserved.
//

import UIKit
import SpriteKit

class YXYCloud: SKShapeNode {
	
	init(size: CGSize) {
		super.init()
		let path = CGPathCreateWithEllipseInRect(CGRect(x: 0, y: 0, width: size.width, height: size.height), nil)
		self.path = createCloudShape()
		fillColor = UIColor.whiteColor()
		cloudMoving()
		
		
	}
	func createCloudShape() -> CGPathRef {
		
		//// Color Declarations
		let color = UIColor(red: 0.976, green: 0.725, blue: 0.258, alpha: 1.000)
		
		//// Bezier Drawing
		var bezierPath = UIBezierPath()
		bezierPath.moveToPoint(CGPointMake(56.38, 49.96))
		bezierPath.addCurveToPoint(CGPointMake(55.66, 45.53), controlPoint1: CGPointMake(56.38, 48.41), controlPoint2: CGPointMake(56.13, 46.92))
		bezierPath.addCurveToPoint(CGPointMake(60.16, 46.7), controlPoint1: CGPointMake(57.01, 46.28), controlPoint2: CGPointMake(58.54, 46.7))
		bezierPath.addCurveToPoint(CGPointMake(70, 36.11), controlPoint1: CGPointMake(65.6, 46.7), controlPoint2: CGPointMake(70, 41.96))
		bezierPath.addCurveToPoint(CGPointMake(69.71, 33.54), controlPoint1: CGPointMake(70, 35.23), controlPoint2: CGPointMake(69.9, 34.37))
		bezierPath.addCurveToPoint(CGPointMake(70, 30.98), controlPoint1: CGPointMake(69.9, 32.72), controlPoint2: CGPointMake(70, 31.86))
		bezierPath.addCurveToPoint(CGPointMake(70, 30.41), controlPoint1: CGPointMake(70, 30.41), controlPoint2: CGPointMake(70, 30.41))
		bezierPath.addLineToPoint(CGPointMake(70, 29.84))
		bezierPath.addCurveToPoint(CGPointMake(63.51, 19.85), controlPoint1: CGPointMake(70, 25.37), controlPoint2: CGPointMake(67.41, 21.38))
		bezierPath.addCurveToPoint(CGPointMake(54, 19), controlPoint1: CGPointMake(61, 19), controlPoint2: CGPointMake(58.67, 19))
		bezierPath.addLineToPoint(CGPointMake(30.2, 19))
		bezierPath.addCurveToPoint(CGPointMake(20.9, 19.75), controlPoint1: CGPointMake(25.33, 19), controlPoint2: CGPointMake(23, 19))
		bezierPath.addLineToPoint(CGPointMake(20.49, 19.85))
		bezierPath.addCurveToPoint(CGPointMake(14, 29.84), controlPoint1: CGPointMake(16.59, 21.38), controlPoint2: CGPointMake(14, 25.37))
		bezierPath.addCurveToPoint(CGPointMake(14, 30.41), controlPoint1: CGPointMake(14, 30.41), controlPoint2: CGPointMake(14, 30.41))
		bezierPath.addLineToPoint(CGPointMake(14, 30.98))
		bezierPath.addCurveToPoint(CGPointMake(20.19, 40.84), controlPoint1: CGPointMake(14, 35.33), controlPoint2: CGPointMake(16.46, 39.23))
		bezierPath.addCurveToPoint(CGPointMake(20.05, 42.63), controlPoint1: CGPointMake(20.1, 41.42), controlPoint2: CGPointMake(20.05, 42.02))
		bezierPath.addCurveToPoint(CGPointMake(22.03, 49), controlPoint1: CGPointMake(20.05, 45.02), controlPoint2: CGPointMake(20.79, 47.23))
		bezierPath.addCurveToPoint(CGPointMake(29.89, 53.22), controlPoint1: CGPointMake(23.83, 51.57), controlPoint2: CGPointMake(26.68, 53.22))
		bezierPath.addCurveToPoint(CGPointMake(32.46, 52.86), controlPoint1: CGPointMake(30.78, 53.22), controlPoint2: CGPointMake(31.64, 53.1))
		bezierPath.addCurveToPoint(CGPointMake(33.18, 55.21), controlPoint1: CGPointMake(32.63, 53.67), controlPoint2: CGPointMake(32.88, 54.46))
		bezierPath.addCurveToPoint(CGPointMake(33.65, 56.23), controlPoint1: CGPointMake(33.35, 55.6), controlPoint2: CGPointMake(33.49, 55.92))
		bezierPath.addCurveToPoint(CGPointMake(44.27, 63), controlPoint1: CGPointMake(35.71, 60.27), controlPoint2: CGPointMake(39.69, 63))
		bezierPath.addCurveToPoint(CGPointMake(56.38, 49.96), controlPoint1: CGPointMake(50.96, 63), controlPoint2: CGPointMake(56.38, 57.16))
		bezierPath.closePath()
		color.setFill()
		bezierPath.fill()
		return bezierPath.CGPath
	
//	self.path = bezierPath.CGPath
//	fillColor = UIColor.whiteColor()
	}
	func cloudMoving() {
		let moveLeft = SKAction.moveByX(-10, y: 0, duration: 1)
		runAction(SKAction.repeatActionForever(moveLeft))
		
	}
	
	required init?(coder aDecoder: NSCoder) {
	    fatalError("init(coder:) has not been implemented")
	}
}
