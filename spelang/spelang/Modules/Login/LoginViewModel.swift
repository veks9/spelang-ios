//
//  LoginViewModel.swift
//  spelang
//
//  Created by Vedran Hernaus on 13.01.2023..
//

import Foundation
import Combine

protocol LoginViewModeling {
    func submitButtonTapped()
    func usernameTextChanged(_ newValue: String?)
    func pinTextChanged(_ newValue: String?)
}

final class LoginViewModel {

    private let router: LoginRouting
    private let userService: UserServicing
    private var cancellables: Set<AnyCancellable> = .init()
    
    private let usernameTextSubject: CurrentValueSubject<String?, Never> = .init(nil)
    private let pinTextSubject: CurrentValueSubject<String?, Never> = .init(nil)
    
    init(
        router: LoginRouting,
        userService: UserServicing = UserService()
    ) {
        self.router = router
        self.userService = userService
    }
}

// MARK: - LoginViewModeling

extension LoginViewModel: LoginViewModeling {
    func usernameTextChanged(_ newValue: String?) {
        usernameTextSubject.send(newValue)
    }
    
    func pinTextChanged(_ newValue: String?) {
        pinTextSubject.send(newValue)
    }
    
    func submitButtonTapped() {
        userService.loginUser(username: usernameTextSubject.value ?? "", pin: pinTextSubject.value ?? "")
            .sink(receiveCompletion: { [weak self] completion in
                guard let self = self else { return }
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("🔴🔴🔴🔴\(error)🔴🔴🔴🔴")
                }
            }, receiveValue: { [weak self] user in
                guard let self = self else { return }
                print("🟢🟢🟢🟢\(user)🟢🟢🟢🟢")
                self.router.navigateToTestList()
            })
            .store(in: &cancellables)
    }
}
