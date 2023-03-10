//
//  GetAllTestsRequest.swift
//  spelang
//
//  Created by Vedran Hernaus on 17.01.2023..
//

import Foundation
import Alamofire

struct GetAllTestsRequest: APIRequest {
    typealias ResponseType = Model.TestLeaderboards
        
    var path: String {
        return Endpoint.getAllTests(username: username).path
    }
    
    var query: [String : String?]?
    var httpMethod: HTTPMethod = .get
    var requestBody: Data?
    var authenticationType: AuthenticationType = .none
    var contentType: ContentType? = .applicationJson
    var username: String
}
