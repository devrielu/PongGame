//
//  MainMenuViewController.swift
//  PongGame
//
//  Created by Lucas Devries on 4/18/23.
//

import Foundation
import UIKit

enum typeOfGame {
    case easy
    case normal
    case difficult
    case player2
}

class MainMenuViewController : UIViewController {
    
    @IBAction func player2(_ sender: Any) {
        transitionToGame(game: .player2)
    }
    
    @IBAction func easy(_ sender: Any) {
        transitionToGame(game: .easy)
    }
    
    @IBAction func normal(_ sender: Any) {
        transitionToGame(game: .normal)
    }
    
    @IBAction func difficult(_ sender: Any) {
        transitionToGame(game: .difficult)
    }
    
    func transitionToGame(game : typeOfGame) {
        //Setting up game screen as transition screen
        let gameView = self.storyboard?.instantiateViewController(withIdentifier: "gameVC") as! GameViewController
        //Setting gametype variable to chosen style
        currType = game
        self.navigationController?.pushViewController(gameView, animated: true)
    }
    
}
