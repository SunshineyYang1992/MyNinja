//
//  YXYPointsLabel.swift
//  Nimble Ninja
//
//  Created by Sunshine Yang on 8/1/15.
//  Copyright (c) 2015 SunshineYang. All rights reserved.
//

import UIKit
import SpriteKit


class YXYPointsLabel: SKLabelNode {
	
	var number = 0
	
	init(num: Int) {
		super.init()
		fontColor = UIColor.whiteColor()
		fontSize = 24
		fontName = "Arial"
		number = num
		text = "\(num)"
		
	}
	
	required init?(coder aDecoder: NSCoder) {
	    fatalError("init(coder:) has not been implemented")
	}
	func increment() {
		number++
		text = "\(number)"
	}
	func setToNumber(number:Int) {
		self.number = number
		text = "\(self.number)"
	}
	
	
}
