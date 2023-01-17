//
//  CreateTestRequest.swift
//  spelang
//
//  Created by Vedran Hernaus on 17.01.2023..
//

import Foundation
import Alamofire

struct CreateTestRequest: APIRequest {
    typealias ResponseType = Model.TestResult
        
    var path: String {
        return Endpoint.createTest.path
    }
    
    var query: [String : String?]?
    var httpMethod: HTTPMethod = .post
    var requestBody: Data?
    var authenticationType: AuthenticationType = .none
    var contentType: ContentType? = .applicationJson
    
    init(bodyModel: Model.CreateTestBody) {
        requestBody = bodyModel.data
    }
}
