//
//  GameScene.swift
//  PongGame
//
//  Created by Lucas Devries on 4/16/23.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var ball = SKSpriteNode()
    var opponent = SKSpriteNode()
    var player = SKSpriteNode()
    
    var gameScore = [Int]()
    var topScore = SKLabelNode()
    var bottomScore = SKLabelNode()
    var background = SKSpriteNode()
        
    override func didMove(to view: SKView) {
        //Setting up background to size of screen being played on
        background = self.childNode(withName: "background") as! SKSpriteNode
        background.size.height = self.frame.height
        background.size.width = self.frame.width
        //Setting each score label
        topScore = self.childNode(withName: "topLabel") as! SKLabelNode
        bottomScore = self.childNode(withName: "bottomLabel") as! SKLabelNode
        player = self.childNode(withName: "main") as! SKSpriteNode
        //setting player position with respect to the screen size
        player.position.y = (-self.frame.height / 2) + 50
        opponent = self.childNode(withName: "opponent") as! SKSpriteNode
        //setting opponent position with respect to screen size
        opponent.position.y = (self.frame.height / 2) - 50
        ball = self.childNode(withName: "ball") as! SKSpriteNode
        //Setting physics for the edges of the screen
        let edge = SKPhysicsBody(edgeLoopFrom: self.frame)
        //var touchLocation = CGPoint?()
        
        //Removing friction, setting restitution to 1
        edge.friction = 0
        edge.restitution = 1
        
        self.physicsBody = edge
        //Start game
        start()
        
        
    }
    
    func start() {
        //Zeroing out score of new game, setting score to the designated labels
        gameScore = [0,0]
        topScore.text = "\(gameScore[1])"
        bottomScore.text = "\(gameScore[0])"
        //Applying initial force to ball to start game
        ball.physicsBody?.applyImpulse(CGVector(dx:18,dy:18))
    }
    
    func scorePoint(scoringPlayer : SKSpriteNode){
        //Called when point is scored, resetting ball
        ball.position = CGPoint(x: 0, y: 0)
        ball.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        //Determining player scored, setting score accordingly
        if scoringPlayer == player {
            //If bottom player scored, add a point
            gameScore[0] += 1
            ball.physicsBody?.applyImpulse(CGVector(dx:18,dy:18))
        }
        else if scoringPlayer == opponent {
            //If top player scored(bot) add a point
            gameScore[1] += 1
            ball.physicsBody?.applyImpulse(CGVector(dx:-18,dy:-18))
        }
        //Set the labels to match the score of the game
        topScore.text = "\(gameScore[1])"
        bottomScore.text = "\(gameScore[0])"
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //When the screen is interacted with
        for touch in touches {
            let location = touch.location(in: self)
            //If the game is in 2 player mode, tracking for both top and bottom players
            if currType == .player2 {
                if location.y > 0 {
                    opponent.run(SKAction.moveTo(x: location.x, duration: 0.1))
                }
                if location.y < 0 {
                    player.run(SKAction.moveTo(x: location.x, duration: 0.1))
                }
            }
            //If in one player mode, tracking for only the bottom player
            else {
                player.run(SKAction.moveTo(x: location.x, duration: 0.1))
            }
        }
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            //If statment for 2-player mode
            if currType == .player2 {
                //Tracking movements while player is moving
                if location.y > 0 {
                    opponent.run(SKAction.moveTo(x: location.x, duration: 0.1))
                }
                if location.y < 0 {
                    player.run(SKAction.moveTo(x: location.x, duration: 0.1))
                }
            }
            else {
                player.run(SKAction.moveTo(x: location.x, duration: 0.1))
            }
        }
    }
    

//            player.position.x = (touchLocation.x)
  //      }
    //}
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        //Switch case to check for the difficulty of the match
        switch currType {
        case .easy:
            opponent.run(SKAction.moveTo(x: ball.position.x, duration: 1.3))
            break
        case .normal:
            opponent.run(SKAction.moveTo(x: ball.position.x, duration: 1.0))
            break
        case .difficult:
            opponent.run(SKAction.moveTo(x: ball.position.x, duration: 0.7))
            break
        case .player2:
            
            break
        
        }
        
        if ball.position.y <= player.position.y - 30 {
            scorePoint(scoringPlayer: opponent)
        }
        else if ball.position.y >= opponent.position.y + 30 {
            scorePoint(scoringPlayer: player)
        }
    }
}
