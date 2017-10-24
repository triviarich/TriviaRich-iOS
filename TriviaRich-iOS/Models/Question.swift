//
//  Question.swift
//  TriviaRich-iOS
//
//  Created by Matthew Rigdon on 10/12/17.
//  Copyright © 2017 com.rigdon. All rights reserved.
//

import UIKit

enum Answer: String {
    case a = "a"
    case b = "b"
    case c = "c"
    case d = "d"
}

class Question: NSObject {

    private(set) var id = 0
    private(set) var text = ""
    private(set) var a = ""
    private(set) var b = ""
    private(set) var c = ""
    private(set) var d = ""
    private(set) var answer = Answer.a
    
    override init() {
        super.init()
    }
    
    init(json: [String : Any]) {
        id = json["id"] as! Int
        text = json["text"] as! String
        a = json["a"] as! String
        b = json["b"] as! String
        c = json["c"] as! String
        d = json["d"] as! String
        answer = Answer(rawValue: json["answer"] as! String)!
    }
    
}
