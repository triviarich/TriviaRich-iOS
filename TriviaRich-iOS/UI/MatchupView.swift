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
    private let playButton = UIButton()
    
    private var dividerViewLeftOffset: Constraint? = nil
    private var dividerViewRightOffset: Constraint? = nil
    private var userViewOffset: Constraint? = nil
    private var opponentViewOffset: Constraint? = nil
    
    func animateIn() {
        userViewOffset?.update(offset: 0)
        opponentViewOffset?.update(offset: 0)
        dividerViewRightOffset?.update(offset: 0)
        dividerViewLeftOffset?.update(offset: 0)
        
        userView.setNeedsLayout()
        opponentView.setNeedsLayout()
        dividerView.setNeedsLayout()
        
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
    
    @objc private func tappedReady() {
        playButton.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            self.playButton.transform = .identity
        }, completion: { complete in
            if complete {
                self.animateCountdown()
            }
        })
    }
    
    private func animateCountdown(seconds: Int = 3) {
        if seconds == -1 {
            return
        } else if seconds == 3 {
            playButton.titleLabel?.font = UIFont.triviarich(style: .boldItalic, size: 32)
            playButton.setTitle("\(seconds)", for: .normal)
            return animateCountdown(seconds: seconds - 1)
        }
        
        UIView.animate(withDuration: 0.1, delay: 0.8, options: [], animations: {
            self.playButton.titleLabel?.alpha = 0
        }, completion: { complete in
            if complete {
                self.playButton.setTitle("\(seconds)", for: .normal)
                UIView.animate(withDuration: 0.1, animations: {
                    self.playButton.titleLabel?.alpha = 1
                }, completion: { complete in
                    if complete {
                        self.animateCountdown(seconds: seconds - 1)
                    }
                })
            }
        })
    }
    
    private func setupDividerView() {
        dividerView.backgroundColor = .black
        dividerView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(dividerView)
        dividerView.snp.makeConstraints { make in
            self.dividerViewRightOffset = make.right.equalTo(self.snp.right).offset(-(UIScreen.main.bounds.size.width / 2)).constraint
            self.dividerViewLeftOffset = make.left.equalTo(self.snp.left).offset(UIScreen.main.bounds.size.width / 2).constraint
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
        playButton.translatesAutoresizingMaskIntoConstraints = false
        playButton.layer.cornerRadius = playButtonSize.half
        playButton.setTitle("Ready!", for: .normal)
        playButton.titleLabel?.font = UIFont.triviarich(style: .boldItalic)
        playButton.backgroundColor = .triviarichGreen
        playButton.tintColor = .white
        playButton.addTarget(self, action: #selector(tappedReady), for: .touchDown)
        addSubview(playButton)
        playButton.snp.makeConstraints { make in
            make.center.equalTo(self.snp.center)
            make.height.equalTo(self.playButtonSize)
            make.width.equalTo(self.playButtonSize)
        }
    }
    
}

