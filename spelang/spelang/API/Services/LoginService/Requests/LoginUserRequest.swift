//
//  LoginUserRequest.swift
//  spelang
//
//  Created by Vedran Hernaus on 13.01.2023..
//

import Foundation
import Alamofire

struct LoginUserRequest: APIRequest {
    typealias ResponseType = Model.User
        
    var path: String {
        return Endpoint.createUser.path
    }
    
    var query: [String : String?]?
    var httpMethod: HTTPMethod = .post
    var requestBody: Data?
    var authenticationType: AuthenticationType = .none
    var contentType: ContentType? = .applicationJson
    
    init(username: String, pin: String) {
        requestBody = Model.LoginUserRequest(username: username, pin: pin).data
    }
}

