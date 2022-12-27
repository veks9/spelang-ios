//
//  UserDefaultsStoring.swift
//  BBL
//
//  Created by Vedran Hernaus on 22.11.2022..
//

import Foundation
import Combine

protocol UserDefaultsStoring {
    var myTeamId: AnyPublisher<Int?, Never> { get }
    
    func setMyTeamId(id: Int?)
}
