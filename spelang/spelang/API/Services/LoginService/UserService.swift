//
//  UserService.swift
//  spelang
//
//  Created by Vedran Hernaus on 13.01.2023..
//

import Foundation
import Combine

final class UserService: UserServicing {
    
    private var userDefaultsStorage: UserDefaultsStoring
    
    init(userDefaultsStorage: UserDefaultsStoring = UserDefaultsStorage.shared) {
        self.userDefaultsStorage = userDefaultsStorage
    }
    
    func loginUser(username: String, pin: String) -> AnyPublisher<Model.User, Model.ErrorResponse> {
        userDefaultsStorage.username = username
        return APIClient.shared.performRequest(LoginUserRequest(username: username, pin: pin)).eraseToAnyPublisher()
    }
}
