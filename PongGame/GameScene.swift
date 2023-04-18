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
    
    override func didMove(to view: SKView) {
        player = self.childNode(withName: "main") as! SKSpriteNode
        opponent = self.childNode(withName: "opponent") as! SKSpriteNode
        ball = self.childNode(withName: "ball") as! SKSpriteNode
       
        ball.physicsBody?.applyImpulse(CGVector(dx:20,dy:20))
        let edge = SKPhysicsBody(edgeLoopFrom: self.frame)
        //var touchLocation = CGPoint?()
        
        edge.friction = 0
        edge.restitution = 1
        
        self.physicsBody = edge
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            let touchLocation = touch.location(in:self)

            player.position.x = (touchLocation.x)
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        opponent.position.x = (ball.position.x)
    }
}
