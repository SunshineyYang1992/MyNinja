//
//  Constants.swift
//  Nimble Ninja
//
//  Created by Sunshine Yang on 7/28/15.
//  Copyright (c) 2015 SunshineYang. All rights reserved.
//

import Foundation
import UIKit

let kYXYGroundHeight: CGFloat = 20.0
let kDefaltXToMovePerSec:CGFloat = 320.0

// Colision detection
let heroCategoty:UInt32 = 0x1 << 0
let wallCategory:UInt32 = 0x1 << 1

// Game constants
let kNumberOfPointsLevel = 5
let kLevelGenerationTimes: [NSTimeInterval] = [1.5, 1.0, 0.8, 0.6, 0.4]
let kNumberOfSeasons: [NSString] = ["space","summer"]
