//
//  TestLeaderboardRequest.swift
//  spelang
//
//  Created by Luka Bokarica on 16.01.2023..
//

import Foundation
import Alamofire

struct TestLeaderboardRequest: APIRequest {
    typealias ResponseType = [Model.TestLeaderboardPosition]
        
    var path: String {
        return Endpoint.testLeaderboard.path
    }
    
    var query: [String : String?]?
    var httpMethod: HTTPMethod = .get
    var requestBody: Data?
    var authenticationType: AuthenticationType = .none
    var contentType: ContentType? = .applicationJson
    
    init(difficulty: String, category: String) {
        requestBody = Model.TestLeaderboardRequest(difficulty: difficulty, category: category).data
    }
}
