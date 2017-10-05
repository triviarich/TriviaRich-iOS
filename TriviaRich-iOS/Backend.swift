//
//  Backend.swift
//  TriviaRich-iOS
//
//  Created by Matthew Rigdon on 9/20/17.
//  Copyright © 2017 com.rigdon. All rights reserved.
//

import UIKit

class Backend: NSObject {
    
    static func getLobbies(completion: (([Lobby]) -> Void)) {
        let path = Bundle.main.path(forResource: "Lobbies", ofType: "json")
        let url = URL(fileURLWithPath: path!)
        let data = try! Data(contentsOf: url)
        let json = try! JSONSerialization.jsonObject(with: data, options: []) as! [[String: Any]]
        completion(json.map { Lobby(json: $0) })
    }

}
