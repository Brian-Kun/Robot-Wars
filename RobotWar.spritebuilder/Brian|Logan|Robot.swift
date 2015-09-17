//
//  Brian|Logan|Robot.swift
//  RobotWar
//
//  Created by Brian Ramirez on 7/7/15.
//  Copyright (c) 2015 MakeGamesWithUs. All rights reserved.
//

import UIKit

class Brian_Logan_Robot: Robot {
   
    enum RobotState {
        case Moving, Turning, Shooting  //All the possible states of the robot
    }
    
    var currentRobotState: RobotState = .Moving
    var timeSinceScanned: CGFloat = 0.0
    let gunToleranceAngle = CGFloat(2.0)
    //var lastEnemyPosition: CGPoint = (0, 0)
    
    override func run() {
        while true {
            switch(currentRobotState) {
            case .Moving:
                moveAhead(100)
            case .Turning:
                turnRobotLeft(180)
                currentRobotState = .Moving
            case .Shooting:
                shoot()
                currentRobotState = .Moving
            }
            
        }
    }
    
    override func hitWall(hitDirection: RobotWallHitDirection, hitAngle: CGFloat) {
        currentRobotState = .Turning
        
    }
    
    override func gotHit() {
//        cancelActiveAction()
//        turnRobotLeft(90)
//        moveAhead(25)
//        turnGunRight(90)
        
    }
    
    
    override func scannedRobot(robot: Robot!, atPosition enemyPosition: CGPoint) {
        
        timeSinceScanned = currentTimestamp()
        if currentRobotState != .Shooting {
            cancelActiveAction()
        }
        turnToEnemyPosition(enemyPosition)
        var currentPosition: CGPoint = position()
        
        turnToEnemyPosition(enemyPosition)
        
        currentRobotState = .Shooting
        if (currentTimestamp() - timeSinceScanned == 1.0) {
            currentRobotState = .Moving
        }
        
//        if (currentPosition.x > enemyPosition.x + 5 && currentPosition.y > enemyPosition.y + 5) {
//            moveAhead(100)
//        } else if (currentPosition.x < enemyPosition.x + 5 && currentPosition.y < enemyPosition.y + 5) {
//            moveBack(100)
//        }
        println(enemyPosition)
    }
    
    
    func turnToEnemyPosition(position: CGPoint) {
        cancelActiveAction()
        
        // calculate angle between turret and enemey
        var angleBetweenTurretAndEnemy = angleBetweenGunHeadingDirectionAndWorldPosition(position)
        
        // turn if necessary
        if angleBetweenTurretAndEnemy > gunToleranceAngle {
            turnRobotRight(Int(abs(angleBetweenTurretAndEnemy)))
//            turnGunRight(Int(abs(angleBetweenTurretAndEnemy)))
        } else if angleBetweenTurretAndEnemy < -gunToleranceAngle {
            turnRobotLeft(Int(abs(angleBetweenTurretAndEnemy)))
//            turnGunLeft(Int(abs(angleBetweenTurretAndEnemy)))
        }
    }
    
//    override func position() -> CGPoint {
//        return position()
//    }
    
}
