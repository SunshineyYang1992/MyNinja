//
//  GameScene.swift
//  Nimble Ninja
//
//  Created by Sunshine Yang on 7/26/15.
//  Copyright (c) 2015 SunshineYang. All rights reserved.
//

import SpriteKit

// Global function
func delay(#seconds: Double, completion:()->()) {
	let popTime = dispatch_time(DISPATCH_TIME_NOW, Int64( Double(NSEC_PER_SEC) * seconds ))
	
	dispatch_after(popTime, dispatch_get_main_queue()) {
		completion()
	}
}

class GameScene: SKScene, SKPhysicsContactDelegate {
	
	var movingGround: YXYMovingGround!
	var hero: YXYHero!
	
	var isGameStarted = false
	var isGameOver = false
	
	var cloudGenerateor: YXYCloudGenerator!
	var wallGenerator :YXYPoopWallGenerator!
	
	var currentLevel = 0
	var currentWeather: Int = 0
	
	var backgroundChangeTimer: NSTimer!
	
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
		backgroundColor = UIColor(red: 1.0/255.0, green: 152.0 / 255.0, blue: 205.0/255.0, alpha: 1.0)
		
		// Add ground
		addMovingGround()
		
		// Add hero
		addHero()
		
		// Add cloudGenerator
		addCloudGenerator()
		
		//Add start label
		addStartLabel()
		
		//Add point label
		addPointsLabel()
		
		// Add physics world
		addPhysicsWorld()
		
		// Load high score
		
		loadHighScore()
//		delay(seconds: 10) { () -> () in
//
//		}
    }
	func addMovingGround() {
		movingGround = YXYMovingGround(size: CGSize(width: view!.frame.width, height: kYXYGroundHeight))
		movingGround.position = CGPoint(x: 0, y: view!.frame.size.height / 2 )
		addChild(movingGround)

	}
	
	func addHero() {
		hero = YXYHero()
		hero.position = CGPoint(x: 70.0, y: movingGround.position.y + movingGround.frame.size.height/2 + hero.frame.size.height/2 )
		addChild(hero)
		hero.breath()

	}
	
	func addCloudGenerator() {
		cloudGenerateor = YXYCloudGenerator(color: UIColor.clearColor(), size: view!.frame.size)
		cloudGenerateor.position = view!.center
		addChild(cloudGenerateor)
		cloudGenerateor.populateCloud(5)
		cloudGenerateor.startGeneratingWithTimer(5)
		
		wallGenerator = YXYPoopWallGenerator(color: UIColor.clearColor(), size: view!.frame.size)
		wallGenerator.position = view!.center
		addChild(wallGenerator)

	}
	
	func addStartLabel() {
		let tapToStart = SKLabelNode(text: "Tap To Start!")
		tapToStart.name = "tapToStartLabel"
		tapToStart.position.x = view!.center.x
		tapToStart.position.y = view!.center.y + 60
		tapToStart.fontColor = UIColor.whiteColor()
		tapToStart.fontName = "Arial"
		tapToStart.fontSize = 22.0
		tapToStart.runAction(blinkAnimation())
		addChild(tapToStart)

	}
	
	func addPointsLabel() {
		
		let pointLabel = YXYPointsLabel(num: 0)
		pointLabel.position = CGPoint(x: 20.0, y: view!.frame.height - 40)
		pointLabel.name = "points"
		addChild(pointLabel)
		
		let highScoreLabel = YXYPointsLabel(num: 0)
		highScoreLabel.position = CGPoint(x: view!.frame.width - 20, y: view!.frame.height - 40)
		highScoreLabel.name = "highScore"
		addChild(highScoreLabel)
		
		let highScoreText = SKLabelNode(text: "High")
		highScoreText.fontColor = UIColor.whiteColor()
		highScoreText.fontSize = 16
		highScoreText.fontName = "Arial"
		highScoreText.position = CGPoint(x: 0, y: -20)
		highScoreLabel.addChild(highScoreText)
		
		
	}
	func addPhysicsWorld() {
	
		physicsWorld.contactDelegate = self
	}
	
	func loadHighScore() {
		let defaults = NSUserDefaults.standardUserDefaults()
		if let highScore = defaults.objectForKey("highScore") as? Int {
			let highScoreLabel = childNodeWithName("highScore") as! YXYPointsLabel
			highScoreLabel.setToNumber(highScore)
		}
	}
	
	// MARK: game life cycle
	func start() {
		if let tapToStartLabel = childNodeWithName("tapToStartLabel") {
			tapToStartLabel.removeFromParent()
		}
		isGameStarted = true
		hero.stopBreathing()
		hero.starRunning()
		movingGround.start()
		wallGenerator.startGeneratingWithTimer(1)

	}
	func gameOver() {
		isGameOver = true
		
		// stop the game
		hero.fall()
		wallGenerator.stopWalls()
		movingGround.stop()
		hero.stop()
		
		// Game Over label 
		let gameOverLabel = SKLabelNode(text: "Game Over!")
		gameOverLabel.fontColor = UIColor.whiteColor()
		gameOverLabel.fontName = "Arail"
		gameOverLabel.fontSize = 22
		gameOverLabel.position.x = view!.center.x
		gameOverLabel.position.y = view!.center.y + 60
		gameOverLabel.runAction(blinkAnimation())
		addChild(gameOverLabel)
		
		// Update high score
		let highScoreLabel = childNodeWithName("highScore") as! YXYPointsLabel
		let pointLabel = childNodeWithName("points") as! YXYPointsLabel
		if highScoreLabel.number <= pointLabel.number {
			highScoreLabel.setToNumber(pointLabel.number)
			let defaults = NSUserDefaults.standardUserDefaults()
			defaults.setInteger(highScoreLabel.number, forKey: "highScore")
		}
	}
	func restart() {
		cloudGenerateor.stopGenerating()
		
		let newScene = GameScene(size: view!.bounds.size)
		newScene.scaleMode = .AspectFill 
		view!.presentScene(newScene)
		
	}
	
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        /* Called when a touch begins */
		if isGameOver {
			restart()
		}else if !isGameStarted {
			start()
		}else {
			hero.flip()
		}
		
    }
   
    override func update(currentTime: CFTimeInterval) {
		
        /* Called before each frame is rendered */
		if wallGenerator.wallTrackers.count > 0 {
			let wall = wallGenerator.wallTrackers[0] as YXYPoopWall
			
			let wallPosition = wallGenerator.convertPoint(wall.position, toNode: self)
			if wallPosition.x < hero.position.x {
				wallGenerator.wallTrackers.removeAtIndex(0)
				let pointLabel = childNodeWithName("points") as! YXYPointsLabel
				pointLabel.increment()
				
				if pointLabel.number % kNumberOfPointsLevel == 0 {
					if currentLevel <= kLevelGenerationTimes.count - 1 && currentWeather <= kNumberOfSeasons.count - 1{
						currentLevel++
						wallGenerator.stopGeneratingWalls()
						wallGenerator.startGeneratingWithTimer(kLevelGenerationTimes[currentLevel])
						changeBackground(kNumberOfSeasons[currentWeather])
						//startSnowing(kNumberOfSeasons[currentWeather])
						//loadSmoke()
						currentWeather++

					}else {
						currentLevel = 0
						currentWeather = 0
					}
					
				}
			}
		}
    }
	// MARK: SKPhysicsContactDelegate
	func didBeginContact(contact: SKPhysicsContact) {
		if !isGameOver {
			gameOver()
		}
	}
	// MARK: Animation 
	func blinkAnimation() -> SKAction {
		let duration = 0.4
		let fadeOut = SKAction.fadeAlphaTo(0, duration: duration)
		let fadeIn = SKAction.fadeAlphaTo(1.0, duration: duration)
		let blink = SKAction.sequence([fadeOut, fadeIn])
		return SKAction.repeatActionForever(blink)
		
	}
	// MARK: Change background 
//	func startChangingBackground(seconds: NSTimeInterval) {
//		backgroundChangeTimer = NSTimer.scheduledTimerWithTimeInterval(seconds, target: self, selector: "backgrounChanging", userInfo: nil, repeats: true)
//	}
	func startSnowing(name:NSString) {
		
		cloudGenerateor.removeCloud()
		var path = NSBundle.mainBundle().pathForResource("Snow", ofType: "sks")
		if let path = path {
			var rainParticle = NSKeyedUnarchiver.unarchiveObjectWithFile(path) as! SKEmitterNode
			if name == "space" {
					rainParticle.position = CGPointMake(self.view!.frame.width/2, self.size.height)
					rainParticle.name = "rainParticle"
					rainParticle.targetNode = self.scene
					 addChild(rainParticle)
			}else {
				rainParticle.particleBirthRate = 0
				rainParticle.removeFromParent()
			}
		}
		
	}
	func loadSmoke() {
		var path = NSBundle.mainBundle().pathForResource("Smoke", ofType: "sks")
		if let path = path {
			var rainParticle = NSKeyedUnarchiver.unarchiveObjectWithFile(path) as! SKEmitterNode
			rainParticle.position = CGPointMake(self.view!.frame.width/2 + 150, self.size.height/2 - 50)
			rainParticle.name = "smokeParticle"
			rainParticle.targetNode = self.scene
			addChild(rainParticle)
		}
	}
	func changeBackground(season: NSString) {
		cloudGenerateor.removeCloud()
		switch season {
			case "summer":
			addBackgroundImage(season)
			case "space":
			addBackgroundImage(season)
			loadSmoke()
			
		default:
				view!.backgroundColor = UIColor(red: 1.0/255.0, green: 152.0 / 255.0, blue: 205.0/255.0, alpha: 1.0)
			
		}
		
	}
	func addBackgroundImage(imageName: NSString) {
		let backgroundTexture = SKTexture(imageNamed:"\(imageName).jpg")
		let backgroundImage = SKSpriteNode(texture: backgroundTexture, size: view!.frame.size)
		backgroundImage.position = view!.center
		backgroundImage.zPosition = -1
		backgroundImage.alpha = 0
		let fadeIn = SKAction.fadeAlphaTo(1.0, duration: 0.5)
		backgroundImage.runAction(fadeIn)
		self.addChild(backgroundImage)

	}
}

