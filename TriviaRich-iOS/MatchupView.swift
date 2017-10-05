//
//  MatchupView.swift
//  TriviaRich-iOS
//
//  Created by Matthew Rigdon on 9/20/17.
//  Copyright © 2017 com.rigdon. All rights reserved.
//

import UIKit
import SnapKit

class MatchupView: UIView {
    
    private let playerViewsOffset = 100
    private let playerImageViewsSize: CGFloat = 100
    private let playButtonSize: CGFloat = 120
    private let playerLabelsOffset = 8
    private let imageAndLabelViewAlpha: CGFloat = 0
    
    private let dividerView = UIView()
    private let userView = UIView()
    private let userImageAndLabelView = UIView()
    private let opponentView = UIView()
    private let opponentImageAndLabelView = UIView()
    
    private var userViewOffset: Constraint? = nil
    private var opponentViewOffset: Constraint? = nil
    
    func animateIn() {
        userViewOffset?.update(offset: 0)
        opponentViewOffset?.update(offset: 0)
        
        userView.setNeedsLayout()
        opponentView.setNeedsLayout()
        
        let timing = CAMediaTimingFunction(controlPoints: 0.1, 0.8, 0.4, 1)
        CATransaction.begin()
        CATransaction.setAnimationTimingFunction(timing)
        
        UIView.animate(withDuration: 1) {
            self.userImageAndLabelView.alpha = 1
            self.opponentImageAndLabelView.alpha = 1
            self.layoutIfNeeded()
        }
        
        CATransaction.commit()
    }
    
    convenience init() {
        self.init(frame: CGRect.zero)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        setupDividerView()
        setupUserView()
        setupOpponentView()
        setupPlayButton()
    }
    
    private func setupDividerView() {
        dividerView.backgroundColor = .black
        dividerView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(dividerView)
        dividerView.snp.makeConstraints { make in
            make.right.equalTo(self.snp.right)
            make.left.equalTo(self.snp.left)
            make.centerY.equalTo(self.snp.centerY)
            make.height.equalTo(1)
        }
    }
    
    private func setupUserView() {
        // user view
        userView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(userView)
        userView.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top)
            make.right.equalTo(self.snp.right)
            make.left.equalTo(self.snp.left)
            make.bottom.equalTo(dividerView.snp.top)
        }
        
        // user image and label view
        userImageAndLabelView.translatesAutoresizingMaskIntoConstraints = false
        userImageAndLabelView.alpha = imageAndLabelViewAlpha
        addSubview(userImageAndLabelView)
        userImageAndLabelView.snp.makeConstraints { make in
            self.userViewOffset = make.left.equalTo(userView.snp.leftMargin).offset(-self.playerViewsOffset).constraint
            make.centerY.equalTo(userView.snp.centerY)
        }
        
        // user image view
        let imageView = UIImageView(image: #imageLiteral(resourceName: "avatar1"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        userImageAndLabelView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.top.equalTo(userImageAndLabelView.snp.top)
            make.left.equalTo(userImageAndLabelView.snp.left)
            make.bottom.equalTo(userImageAndLabelView.snp.bottom)
            make.width.equalTo(self.playerImageViewsSize)
            make.height.equalTo(self.playerImageViewsSize)
        }
        imageView.layer.cornerRadius = playerImageViewsSize.half
        imageView.clipsToBounds = true
        
        // user label view
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.triviarich(style: .boldItalic, size: 26)
        label.text = "User"
        userImageAndLabelView.addSubview(label)
        label.snp.makeConstraints { make in
            make.left.equalTo(imageView.snp.right).offset(self.playerLabelsOffset)
            make.centerY.equalTo(userImageAndLabelView.snp.centerY)
        }
        label.sizeToFit()
    }
    
    private func setupOpponentView() {
        // opponent view
        opponentView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(opponentView)
        opponentView.snp.makeConstraints { make in
            make.top.equalTo(dividerView.snp.bottom)
            make.right.equalTo(self.snp.right)
            make.bottom.equalTo(self.snp.bottom)
            make.left.equalTo(self.snp.left)
        }
        
        // opponent image and label view
        opponentImageAndLabelView.translatesAutoresizingMaskIntoConstraints = false
        opponentImageAndLabelView.alpha = imageAndLabelViewAlpha
        addSubview(opponentImageAndLabelView)
        opponentImageAndLabelView.snp.makeConstraints { make in
            self.opponentViewOffset = make.right.equalTo(opponentView.snp.rightMargin).offset(self.playerViewsOffset).constraint
            make.centerY.equalTo(opponentView.snp.centerY)
        }
        
        // opponent image view
        let imageView = UIImageView(image: #imageLiteral(resourceName: "avatar2"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        opponentImageAndLabelView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.top.equalTo(opponentImageAndLabelView.snp.top)
            make.right.equalTo(opponentImageAndLabelView.snp.right)
            make.bottom.equalTo(opponentImageAndLabelView.snp.bottom)
            make.width.equalTo(self.playerImageViewsSize)
            make.height.equalTo(self.playerImageViewsSize)
        }
        imageView.layer.cornerRadius = playerImageViewsSize.half
        imageView.clipsToBounds = true
        
        // user label view
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.triviarich(style: .boldItalic, size: 26)
        label.text = "Opponent"
        opponentImageAndLabelView.addSubview(label)
        label.snp.makeConstraints { make in
            make.right.equalTo(imageView.snp.left).offset(-self.playerLabelsOffset)
            make.centerY.equalTo(opponentImageAndLabelView.snp.centerY)
        }
        label.sizeToFit()
    }
    
    private func setupPlayButton() {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = playButtonSize.half
        button.setTitle("Ready!", for: UIControlState.normal)
        button.titleLabel?.font = UIFont.triviarich(style: .boldItalic)
        button.backgroundColor = .triviarichGreen
        button.tintColor = .white
        addSubview(button)
        button.snp.makeConstraints { make in
            make.center.equalTo(self.snp.center)
            make.height.equalTo(self.playButtonSize)
            make.width.equalTo(self.playButtonSize)
        }
    }
    
}

