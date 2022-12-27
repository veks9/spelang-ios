//
//  Endpoint.swift
//  Pokemons
//
//  Created by Krešimir Baković on 19/11/2020.
//  Copyright © 2020 Kreso Bakovic. All rights reserved.
//

import Foundation

enum Endpoint {
    case getAllPlayers
    case getLeagueTable
    case getAllVenues
    case getAllTeams
    case getTeam(Int)
    case getAllMatchups
    
    var path: String {
        return NetworkConstants.baseURLString + _path
    }

    private var _path: String {
        switch self {
        case .getAllPlayers:
            return "/bbl-api/v1/players"
        case .getLeagueTable:
            return "/bbl-api/v1/table"
        case .getAllVenues:
            return "/sportspress/v2/venues"
        case .getAllTeams:
            return "/sportspress/v2/teams"
        case .getTeam(let id):
            return "/sportspress/v2/teams/\(id)"
        case .getAllMatchups:
            return "/sportspress/v2/calendars"
        }
    }
}
