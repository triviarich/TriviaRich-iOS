//
//  Lobby.swift
//  TriviaRich-iOS
//
//  Created by Matthew Rigdon on 9/20/17.
//  Copyright © 2017 com.rigdon. All rights reserved.
//

import UIKit

class Lobby: NSObject {
    
    var id = 0
    var price = 0
    
    override init() {
        super.init()
    }
    
    init(json: [String: Any]) {
        id = json["id"] as! Int
        price = json["price"] as! Int
    }
    
    func priceString(capitalized: Bool = false) -> String {
        if (capitalized) {
            return price == 0 ? "Free" : "$\(price)"
        }
        
        return price == 0 ? "free" : "$\(price)"
    }

}
