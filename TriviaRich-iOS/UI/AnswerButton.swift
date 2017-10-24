//
//  AnswerButton.swift
//  TriviaRich-iOS
//
//  Created by Matthew Rigdon on 10/12/17.
//  Copyright © 2017 com.rigdon. All rights reserved.
//

import UIKit

class AnswerButton: UIButton {
    
    var correct = false

    convenience init() {
        self.init(frame: CGRect.zero)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor.triviarichGreen
        titleLabel?.font = UIFont.triviarich(style: .boldItalic)
    }

}
