//
//  UserServicing.swift
//  spelang
//
//  Created by Vedran Hernaus on 13.01.2023..
//

import Foundation
import Combine

protocol UserServicing {
    func loginUser(username: String, pin: String) -> AnyPublisher<Model.User, Model.ErrorResponse>
}
