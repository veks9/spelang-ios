//
//  Assets.swift
//  BBL
//
//  Created by Vedran Hernaus on 16.10.2022..
//

import Foundation

import UIKit

enum Assets: String {

    case myTeamTabIcon
    case teamsTabIcon
    case mediaTabIcon
    case matchupsTabIcon
    case leagueTabIcon
    case myTeamSelectedTabIcon
    case teamsSelectedTabIcon
    case mediaSelectedTabIcon
    case matchupsSelectedTabIcon
    case leagueSelectedTabIcon
    case addTeamIcon
    case searchIcon
    case searchXIcon
    case deleteIcon
    case moreInformationIcon
    case backArrow
    case basketballIcon
    case calendarIcon
    case timeIcon
    case locationIcon
    case filterIcon
    case externalLinkIcon
    case noMediaResults
    
    var image: UIImage? {
        return UIImage(named: rawValue)
    }

    var systemImage: UIImage? {
        return UIImage(systemName: rawValue)
    }
}
