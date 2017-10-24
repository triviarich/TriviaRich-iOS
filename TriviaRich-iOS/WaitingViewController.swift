//
//  WaitingViewController.swift
//  TriviaRich-iOS
//
//  Created by Matthew Rigdon on 9/20/17.
//  Copyright © 2017 com.rigdon. All rights reserved.
//

import UIKit
import ActionCableClient

extension WaitingViewController: MatchupViewDelegate {
    func onReady() {
        self.performSegue(withIdentifier: "questionsSegue", sender: self)
    }
}

class WaitingViewController: UIViewController {
    
    @IBOutlet weak var containerView: UIView!
    
    var lobby = Lobby()
    var game = Game()
    
    private var socket: ActionCableClient!
    
    private var loadingView = LoadingView()
    private var matchupView = MatchupView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "\(lobby.priceString(capitalized: true)) game"
        
        setupLoadingView()
        setupMatchupView()
        Backend.requestGame { game in
            if let game = game {
                self.game = game
                if game.open {
                    self.waitForOpponent()
                } else {
                    self.transitionToMatchupView()
                }
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        loadingView.beginAnimation()
    }
    
    private func waitForOpponent() {
        socket = ActionCableClient(url: URL(string: "ws://localhost:3000/cable")!)
        socket.connect()
        socket.onConnected = {
            let channel = self.socket.create("GamesChannel", identifier: ["id": self.game.id])
            channel.onReceive = { json, error in
                if let _ = json as? [String: Any] {
                    self.game.open = false
                    self.transitionToMatchupView()
                }
            }
        }
    }
    
    private func transitionToMatchupView() {
        UIView.transition(from: self.loadingView, to: self.matchupView, duration: 0.5, options: [.transitionCrossDissolve, .showHideTransitionViews]) { complete in
            self.matchupView.animateIn()
        }
    }
    
    private func setupLoadingView() {
        containerView.addSubview(loadingView)
        loadingView.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.top)
            make.right.equalTo(containerView.snp.right)
            make.bottom.equalTo(containerView.snp.bottom)
            make.left.equalTo(containerView.snp.left)
        }
    }
    
    private func setupMatchupView() {
        matchupView.delegate = self
        containerView.addSubview(matchupView)
        matchupView.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.top)
            make.right.equalTo(containerView.snp.right)
            make.bottom.equalTo(containerView.snp.bottom)
            make.left.equalTo(containerView.snp.left)
        }
        matchupView.isHidden = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "questionsSegue" {
            (segue.destination as! QuestionsViewController).game = game
        }
    }

}
