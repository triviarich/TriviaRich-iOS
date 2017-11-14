//
//  AnswerButton.swift
//  TriviaRich-iOS
//
//  Created by Matthew Rigdon on 10/12/17.
//  Copyright © 2017 com.rigdon. All rights reserved.
//

import UIKit

protocol AnswerButtonDelegate {
    func didTap(button: AnswerButton)
}

class AnswerButton: UIButton {
    
    var delegate: AnswerButtonDelegate?
    
    override open var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? UIColor.triviarichGreen.withAlphaComponent(0.5) : UIColor.triviarichGreen
        }
    }
    
    var correct = false

    convenience init() {
        self.init(frame: CGRect.zero)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.triviarichGreen
        titleLabel?.font = UIFont.triviarich(style: .boldItalic)
        addTarget(nil, action: #selector(tapped), for: .touchUpInside)
    }
    
    @objc private func tapped() {
        delegate?.didTap(button: self)
    }

}
