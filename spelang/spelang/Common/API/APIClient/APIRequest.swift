//
//  APIRequest.swift
//  Pokemons
//
//  Created by Krešimir Baković on 19/11/2020.
//  Copyright © 2020 Kreso Bakovic. All rights reserved.
//

import Foundation
import Alamofire

protocol APIRequest {
    associatedtype ResponseType: Decodable

    var path: String { get }
    var query: [String: String?]? { get }
    var httpMethod: HTTPMethod { get }
    var requestBody: Data? { get }
    var authenticationType: AuthenticationType { get }
    var contentType: ContentType? { get }
}

extension APIRequest {
    func urlRequest() -> URLRequest {
        let url = URL(string: path)!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = httpMethod.rawValue
        urlRequest.httpBody = requestBody
        urlRequest.setValue(contentType?.httpHeaderText, forHTTPHeaderField: "Content-Type")
        query == nil ? () : query?.forEach { urlRequest.url?.appendQueryItem(name: $0.key, value: $0.value) }
        
        switch authenticationType {
        case .none:
            break
        case .oAuth2:
            urlRequest.setValue("", forHTTPHeaderField: "Authorization")
        }

        return urlRequest
    }
}
