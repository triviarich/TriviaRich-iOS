//
//  LoadingView.swift
//  TriviaRich-iOS
//
//  Created by Matthew Rigdon on 9/20/17.
//  Copyright © 2017 com.rigdon. All rights reserved.
//

import UIKit
import SnapKit

class LoadingView: UIView {

    private let playButtonSize: CGFloat = 120
    
    private let shockwave = UIView()
    private let findingButton = UIButton()
    
    convenience init() {
        self.init(frame: CGRect.zero)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        setupShockwave()
        setupPlayButton()
    }
    
    func beginAnimation() {
        Timer.scheduledTimer(withTimeInterval: 2, repeats: true) { timer in
            DispatchQueue.main.async {
                CATransaction.begin()
                
                // shockwave animations
                self.shockwave.snp.updateConstraints { make in
                    make.size.equalTo(800)
                }
                self.shockwave.setNeedsLayout()
                UIView.animate(withDuration: 0.8, animations: {
                    self.shockwave.layer.cornerRadius = 400
                    self.shockwave.layoutIfNeeded()
                }, completion: { complete in
                    UIView.animate(withDuration: 0.2, animations: {
                        self.shockwave.alpha = 0
                    }, completion: { complete in
                        self.shockwave.snp.updateConstraints { make in
                            make.size.equalTo(self.playButtonSize)
                        }
                        self.shockwave.alpha = 1
                        self.shockwave.layer.cornerRadius = self.playButtonSize.half
                    })
                })
                
                // searching spring animation
                self.findingButton.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
                UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                    self.findingButton.transform = .identity
                })
                
                CATransaction.commit()
            }
        }.fire()
    }
    
    private func setupShockwave() {
        shockwave.translatesAutoresizingMaskIntoConstraints = false
        shockwave.layer.cornerRadius = playButtonSize.half
        shockwave.layer.borderColor = UIColor.triviarichGreen.cgColor
        shockwave.layer.borderWidth = 2
        shockwave.backgroundColor = UIColor.triviarichGreen.withAlphaComponent(0.3)
        addSubview(shockwave)
        shockwave.snp.makeConstraints { make in
            make.center.equalTo(self.snp.center)
            make.size.equalTo(self.playButtonSize)
        }
    }
    
    private func setupPlayButton() {
        findingButton.translatesAutoresizingMaskIntoConstraints = false
        findingButton.layer.cornerRadius = playButtonSize.half
        findingButton.setTitle("Searching", for: UIControlState.normal)
        findingButton.titleLabel?.font = UIFont.triviarich(style: .boldItalic)
        findingButton.backgroundColor = .triviarichGreen
        findingButton.tintColor = .white
        addSubview(findingButton)
        findingButton.snp.makeConstraints { make in
            make.center.equalTo(self.snp.center)
            make.height.equalTo(self.playButtonSize)
            make.width.equalTo(self.playButtonSize)
        }
    }

}
