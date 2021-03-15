//
//  AuthController.swift
//  alarstudios
//
//  Created by Alex Bro on 11.03.2021.
//

import UIKit

protocol AuthViewProtocol: AnyObject {
    func onSuccessLogin()
    func onBadLogin()
    func showError(errorString: String)
}

final class AuthViewController: UIViewController {
    
    private lazy var authView = AuthView()
    private var viewModel: AuthViewModel
    
    init(viewModel: AuthViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Авторизация"
        addAuthView()
        setupButtonAction()
    }
    
    @objc func onLoginClick() {
        authView.showActivity()
        let login = authView.loginTextField.text
        let password = authView.passwordTextField.text
        viewModel.login(with: login, password: password)
    }

//MARK: - Private methods
    private func addAuthView() {
        view.addSubview(authView)
        authView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            authView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            authView.topAnchor.constraint(equalTo: view.topAnchor),
            authView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            authView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupButtonAction() {
        authView.loginButton.addTarget(self, action: #selector(onLoginClick), for: .touchUpInside)
    }
}

//MARK: - AuthViewProtocol
extension AuthViewController: AuthViewProtocol {
    
    func onSuccessLogin() {
        authView.showSuccess()
        authView.hideActivity()
        viewModel.showListView()
    }
    
    func onBadLogin() {
        authView.shake()
        authView.showUnsuccess()
    }
    
    func showError(errorString: String) {
        self.showBaseInfoAlert(description: errorString)
        authView.hideActivity()
    }
}
