//
//  AccountViewModel.swift
//  Arbuz-clone
//
//  Created by kakim nyssanov on 18.05.2024.
//

import Foundation
import Combine

class AccountViewModel: ObservableObject {
    @Published var username: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var user: User?
    @Published var isLoggedIn: Bool = false

    private var cancellables = Set<AnyCancellable>()

    init() {
    }

    func login() {
        ApiService.shared.login(username: username, password: password){ result in
            switch result{
            case .success(let res):
                self.isLoggedIn = res
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.user = User(username: self.username, email: self.email)
                }
            case .failure(_):
                self.isLoggedIn = false
                self.user = nil
            }
        }
    }

    func signup() {
        ApiService.shared.signup(username: username, password: password, email: email) { result in
            switch result {
            case .success:
                self.login()
            case .failure(let error):
                print("Signup error: \(error)")
            }
        }
    }

    func logout() {
        user = nil
        ApiService.shared.logout()
    }
}

struct User: Codable {
    let username: String
    let email: String
}
