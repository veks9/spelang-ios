//
//  NetworkConstants.swift
//  Pokemons
//
//  Created by Krešimir Baković on 19/11/2020.
//  Copyright © 2020 Kreso Bakovic. All rights reserved.
//

import Foundation

struct NetworkConstants {
    static let baseURLString = "https://bbl.hr/wp-json"
    static let baseURL = URL(string: baseURLString)!
    
    static let youtubeURLString = "https://www.googleapis.com/youtube/v3/search"
    static let youtubeURL = URL(string: youtubeURLString)!
}
