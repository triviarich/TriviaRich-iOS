//
//  QuestionsViewController.swift
//  TriviaRich-iOS
//
//  Created by Matthew Rigdon on 10/12/17.
//  Copyright © 2017 com.rigdon. All rights reserved.
//

import UIKit

extension QuestionsViewController: AnswerButtonDelegate {
    func didTap(button: AnswerButton) {
        let currentIndex = game.questions.index(of: currentQuestion)
    }
}

class QuestionsViewController: UIViewController {
    
    private let buttonHeight = 50
    private let buttonMargin = 32
    
    var game = Game()
    
    private var currentQuestion = Question()
    
    private let remainingLabel = UILabel()
    fileprivate let answerAButton = AnswerButton()
    private let answerBButton = AnswerButton()
    private let answerCButton = AnswerButton()
    private let answerDButton = AnswerButton()
    private let questionLabel = UITextView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentQuestion = game.questions.first!
        
        setupRemainingLabel()
        setupAnswerDButton()
        setupAnswerCButton()
        setupAnswerBButton()
        setupAnswerAButton()
        setupQuestionLabel()
        
        let time = TimeInterval()
        time.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func setupRemainingLabel() {
        remainingLabel.translatesAutoresizingMaskIntoConstraints = false
        remainingLabel.text = "1/\(game.questions.count)"
        remainingLabel.font = UIFont.triviarich(style: .boldItalic)
        view.addSubview(remainingLabel)
        remainingLabel.snp.makeConstraints { make in
            make.top.equalTo(self.view.snp.topMargin).offset(16)
            make.centerX.equalTo(self.view.snp.centerX)
        }
        remainingLabel.sizeToFit()
    }
    
    private func setupAnswerDButton() {
        answerDButton.setTitle(currentQuestion.d, for: .normal)
        answerDButton.correct = currentQuestion.answer == .d
        view.addSubview(answerDButton)
        answerDButton.snp.makeConstraints { make in
            make.left.equalTo(self.view.snp.leftMargin)
            make.bottom.equalTo(self.view.snp.bottomMargin).offset(-self.buttonMargin)
            make.right.equalTo(self.view.snp.rightMargin)
            make.height.equalTo(self.buttonHeight)
        }
    }
    
    private func setupAnswerCButton() {
        answerCButton.setTitle(currentQuestion.c, for: .normal)
        answerCButton.correct = currentQuestion.answer == .c
        view.addSubview(answerCButton)
        answerCButton.snp.makeConstraints { make in
            make.left.equalTo(self.view.snp.leftMargin)
            make.bottom.equalTo(self.answerDButton.snp.topMargin).offset(-self.buttonMargin)
            make.right.equalTo(self.view.snp.rightMargin)
            make.height.equalTo(self.buttonHeight)
        }
    }
    
    private func setupAnswerBButton() {
        answerBButton.setTitle(currentQuestion.b, for: .normal)
        answerBButton.correct = currentQuestion.answer == .b
        view.addSubview(answerBButton)
        answerBButton.snp.makeConstraints { make in
            make.left.equalTo(self.view.snp.leftMargin)
            make.bottom.equalTo(self.answerCButton.snp.topMargin).offset(-self.buttonMargin)
            make.right.equalTo(self.view.snp.rightMargin)
            make.height.equalTo(self.buttonHeight)
        }
    }
    
    private func setupAnswerAButton() {
        answerAButton.setTitle(currentQuestion.a, for: .normal)
        answerAButton.correct = currentQuestion.answer == .a
        view.addSubview(answerAButton)
        answerAButton.snp.makeConstraints { make in
            make.left.equalTo(self.view.snp.leftMargin)
            make.bottom.equalTo(self.answerBButton.snp.topMargin).offset(-self.buttonMargin)
            make.right.equalTo(self.view.snp.rightMargin)
            make.height.equalTo(self.buttonHeight)
        }
    }
    
    private func setupQuestionLabel() {
        questionLabel.translatesAutoresizingMaskIntoConstraints = false
        questionLabel.text = currentQuestion.text
        questionLabel.font = UIFont.triviarich(style: .regular, size: 28)
        questionLabel.isEditable = false
        questionLabel.isSelectable = false
        questionLabel.adjustsFontForContentSizeCategory = true
        view.addSubview(questionLabel)
        questionLabel.snp.makeConstraints { make in
            make.top.equalTo(self.remainingLabel.snp.bottom).offset(16)
            make.left.equalTo(self.view.snp.leftMargin)
            make.right.equalTo(self.view.snp.rightMargin)
            make.bottom.equalTo(self.answerAButton.snp.top).offset(-self.buttonMargin)
        }
    }

}
