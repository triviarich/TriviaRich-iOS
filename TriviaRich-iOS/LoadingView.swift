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

    convenience init() {
        self.init(frame: CGRect.zero)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        setupLabel()
    }
    
    private func setupLabel() {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Loading..."
        addSubview(label)
        label.snp.makeConstraints { make in
            make.center.equalTo(self)
        }
        label.sizeToFit()
    }

}
