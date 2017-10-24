//
//  Backend.swift
//  TriviaRich-iOS
//
//  Created by Matthew Rigdon on 9/20/17.
//  Copyright © 2017 com.rigdon. All rights reserved.
//

import UIKit
import Alamofire

class Backend: NSObject {
    
    static func getLobbies(completion: (([Lobby]) -> Void)) {
        let path = Bundle.main.path(forResource: "Lobbies", ofType: "json")
        let url = URL(fileURLWithPath: path!)
        let data = try! Data(contentsOf: url)
        let json = try! JSONSerialization.jsonObject(with: data, options: []) as! [[String: Any]]
        completion(json.map { Lobby(json: $0) })
    }
    
    static func requestGame(completion: @escaping ((Game?) -> Void)) {
        Alamofire.request(endpoint(urlString: "games/game_request")).responseJSON { response in
            if let json = response.result.value as? [String : Any] {
                completion(Game(json: json))
            } else {
                completion(nil)
            }
        }
    }
    
    private static func endpoint(urlString: String) -> String {
        return "http://localhost:3000/api/v1/\(urlString).json"
    }

}
