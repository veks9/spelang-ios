//
//  GetTestByCategoryAndDifficulty.swift
//  spelang
//
//  Created by Vedran Hernaus on 17.01.2023..
//

import Foundation
import Alamofire

struct GetTestByCategoryAndDifficulty: APIRequest {
    typealias ResponseType = [Model.TestWord]
        
    var path: String {
        return Endpoint.getTest(category: categoryName, difficulty: difficulty).path
    }
    
    var query: [String : String?]?
    var httpMethod: HTTPMethod = .get
    var requestBody: Data?
    var authenticationType: AuthenticationType = .none
    var contentType: ContentType? = .applicationJson
    var categoryName: String
    var difficulty: String
}
