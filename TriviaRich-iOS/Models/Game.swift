//
//  Game.swift
//  TriviaRich-iOS
//
//  Created by Matthew Rigdon on 10/22/17.
//  Copyright © 2017 com.rigdon. All rights reserved.
//

import UIKit

class Game: NSObject {
    
    var open = false
    
    private(set) var id = 0
    private(set) var questions = [Question]()
    
    override init() {
        super.init()
    }
    
    init(json: [String : Any]) {
        id = json["id"] as! Int
        open = json["open"] as! Bool
        questions = (json["questions"] as! [[String : Any]]).map { Question(json: $0) }
    }

}
