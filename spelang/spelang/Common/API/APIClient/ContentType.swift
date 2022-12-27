//
//  ContentType.swift
//  Pokemons
//
//  Created by Krešimir Baković on 25.05.2022..
//

import Foundation

enum ContentType {
    case formUrlEncoded
    case applicationJson
    case multipartFormData
    case textPlain

    var httpHeaderText: String {
        switch self {
        case .formUrlEncoded:
            return "application/x-www-form-urlencoded"
        case .applicationJson:
            return "application/json"
        case .multipartFormData:
            return "multipart/form-data"
        case .textPlain:
            return "text/plain"
        }
    }
}
