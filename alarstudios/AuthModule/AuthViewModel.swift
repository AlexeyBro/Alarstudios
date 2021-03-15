//
//  AuthViewModel.swift
//  alarstudios
//
//  Created by Alex Bro on 11.03.2021.
//

import Foundation
import UIKit

protocol AuthViewModel {
    func login(with login: String?, password: String?)
    func showListView()
}

final class AuthViewModelImpl: AuthViewModel {
    
    weak var view: AuthViewProtocol?
    private var networkManager: AuthNetworkManager
    private var router: Router
    
    init(networkManager: AuthNetworkManager, router: Router) {
        self.networkManager = networkManager
        self.router = router
    }
    
    func login(with login: String?, password: String?) {
        let request = LoginRequest(username: login, password: password)
        networkManager.login(with: request) { [weak self] result in
            switch result {
            case .success(let response):
                if response.status == "ok" {
                    UserDefaults.standard.set(response.code, forKey: "code")
                    DispatchQueue.main.async { self?.view?.onSuccessLogin() }
                } else {
                    DispatchQueue.main.async { self?.view?.onBadLogin() }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.view?.showError(errorString: error.localizedDescription)
                }
            }
        }
    }
    
    func showListView() {
        router.toListViewController()
    }
}
