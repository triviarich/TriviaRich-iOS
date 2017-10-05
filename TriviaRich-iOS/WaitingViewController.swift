//
//  WaitingViewController.swift
//  TriviaRich-iOS
//
//  Created by Matthew Rigdon on 9/20/17.
//  Copyright © 2017 com.rigdon. All rights reserved.
//

import UIKit

class WaitingViewController: UIViewController {
    
    @IBOutlet weak var containerView: UIView!
    
    var lobby = Lobby()
    
    private var loadingView = LoadingView()
    private var matchupView = MatchupView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "\(lobby.priceString(capitalized: true)) game"
        
        setFoundOpponent()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        matchupView.animateIn()
    }
    
    private func setWaiting() {
        containerView.removeSubviews()
        containerView.addSubview(loadingView)
        loadingView.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.top)
            make.right.equalTo(containerView.snp.right)
            make.bottom.equalTo(containerView.snp.bottom)
            make.left.equalTo(containerView.snp.left)
        }
    }
    
    private func setFoundOpponent() {
        containerView.removeSubviews()
        containerView.addSubview(matchupView)
        matchupView.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.top)
            make.right.equalTo(containerView.snp.right)
            make.bottom.equalTo(containerView.snp.bottom)
            make.left.equalTo(containerView.snp.left)
        }
    }

}
