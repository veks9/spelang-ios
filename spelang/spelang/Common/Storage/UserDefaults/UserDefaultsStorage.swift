//
//  UserDefaultsStorage.swift
//  BBL
//
//  Created by Vedran Hernaus on 22.11.2022..
//

import Foundation
import Combine

final class UserDefaultsStorage: UserDefaultsStoring {
    private let userDefaults = UserDefaults.standard
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    private var cancellables = Set<AnyCancellable>()

    static let shared = UserDefaultsStorage()
    
    static let defaultMyTeamId = -1

    private init() {}

    // MARK: - Keys

    static let myTeamIdKey = "myTeamId"
    
    // MARK: - Properties
    
    lazy var myTeamId: AnyPublisher<Int?, Never> = {
        userDefaults
            .publisher(for: \.myTeamId)
            .map { $0 == UserDefaultsStorage.defaultMyTeamId ? nil : $0 }
            .eraseToAnyPublisher()
    }()

    func setMyTeamId(id: Int?) {
        userDefaults.set(id, forKey: UserDefaultsStorage.myTeamIdKey)
    }
}

extension UserDefaults {
    @objc var myTeamId: Int {
        get {
            object(forKey: UserDefaultsStorage.myTeamIdKey) as? Int ?? UserDefaultsStorage.defaultMyTeamId
        }
        set {
            set(newValue, forKey: UserDefaultsStorage.myTeamIdKey)
        }
    }
}
