//
//  Animation.swift
//  Project
//
//  Created by Surbhi Handa on 2017-11-19.
//  Copyright © 2017 Xcode User. All rights reserved.
//
/***********************************************************************************
Author: Surbhi Handa
Purpose: Used to create animation using spritekit when driver accpets the request
*************************************************************************************/

import UIKit
import SpriteKit
import GameplayKit

class Animation: SKScene {
    
    var carFrames:[SKTexture]?
 
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)

    }
    
    override init(size: CGSize) {
        super.init(size: size)
        self.backgroundColor = UIColor.white
        
        var frames:[SKTexture] = []
        
        let carAtlas = SKTextureAtlas(named: "Car")
        
        
        for index in 1 ... 2 {
        let textureName = "car_\(index)"
        let texture = carAtlas.textureNamed(textureName)
        frames.append(texture)
        }

        self.carFrames = frames
        
    }
    /***********************************************************************
     *Author: Surbhi Handa                                                  *
     *The method below animates the sprite kit                             *
     ***********************************************************************/
    func move(){
        
        let texture = self.carFrames![0]
        
        let car = SKSpriteNode(texture: texture)
        
        car.size = CGSize(width: 80, height: 65)
        
        let randomYPositionGenerator = GKRandomDistribution(lowestValue: 50, highestValue: 50)
        let yPosition = CGFloat(randomYPositionGenerator.nextInt())
        
        let rightToLeft = arc4random()%2 == 0
        
        let xPosition = rightToLeft ? self.frame.size.width + car.size.width / 2 : -car.size.width / 2
        car.position = CGPoint(x: xPosition, y: yPosition)
        
        if rightToLeft{
            car.xScale = -1
        }
        self.addChild(car)
        
        car.run(SKAction.repeatForever(SKAction.animate(with: self.carFrames!, timePerFrame: 0.05, resize: false, restore: true)))
        
        var distanceToCover = self.frame.size.width + car.size.width
        
        if rightToLeft{
            distanceToCover *= -1
        }
        let time = TimeInterval(abs(distanceToCover / 140))
        
        let moveAction = SKAction.moveBy(x: distanceToCover, y: 0, duration: time)
        
        let removeAction = SKAction.run{
            
            car.removeAllActions()
            car.removeFromParent()
        }
        let allActions = SKAction.sequence([moveAction, removeAction])
        car.run(allActions)
        
    }
    
    
}
