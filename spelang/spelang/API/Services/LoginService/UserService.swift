//
//  UserService.swift
//  spelang
//
//  Created by Vedran Hernaus on 13.01.2023..
//

import Foundation
import Combine

final class UserService: UserServicing {
    func loginUser(username: String, pin: String) -> AnyPublisher<Model.User, Model.ErrorResponse> {
        UserDefaultsStorage.shared.username = username
        return APIClient.shared.performRequest(LoginUserRequest(username: username, pin: pin)).eraseToAnyPublisher()
    }
}
