//
//  AuthView.swift
//  alarstudios
//
//  Created by Alex Bro on 11.03.2021.
//

import UIKit

final class AuthView: UIView {
    
    lazy var loginTextField = UITextField(placeholder: "Логин", borderStyle: .roundedRect)
    lazy var passwordTextField = UITextField(placeholder: "Пароль", borderStyle: .roundedRect, isSecure: true)
    lazy var loginButton = UIButton(title: "Войти", titleColor: .systemBlue)
    lazy var unsuccessLoginLabel = UILabel()
    lazy var activity = UIActivityIndicatorView()
    lazy var stackView = UIStackView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configurView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func showActivity() {
        loginButton.setTitle("", for: .normal)
        activity.startAnimating()
    }
    
    func hideActivity() {
        loginButton.setTitle("Вход", for: .normal)
        activity.stopAnimating()
    }
    
    func showSuccess() {
        unsuccessLoginLabel.isHidden = true
        errorTextField(loginTextField, isError: false)
        errorTextField(passwordTextField, isError: false)
        hideActivity()
    }
    
    func showUnsuccess() {
        unsuccessLoginLabel.isHidden = false
        errorTextField(loginTextField, isError: true)
        errorTextField(passwordTextField, isError: true)
        hideActivity()
    }
    
//MARK: - Private mothods
    private func configurView() {
        setupStackView()
        setupLoginButtonActivity()
        setupUnsuccessLoginLabel()
    }
    
    private func setupStackView() {
        let subviews = [loginTextField, passwordTextField, loginButton]
        stackView = UIStackView(arrangedSubviews: subviews, axis: .vertical)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.widthAnchor.constraint(equalToConstant: 200),
            stackView.heightAnchor.constraint(equalToConstant: 120),
            stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
    
    private func setupLoginButtonActivity() {
        loginButton.addSubview(activity)
        activity.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activity.centerXAnchor.constraint(equalTo: loginButton.centerXAnchor),
            activity.centerYAnchor.constraint(equalTo: loginButton.centerYAnchor)
        ])
    }
    
    private func setupUnsuccessLoginLabel() {
        self.addSubview(unsuccessLoginLabel)
        unsuccessLoginLabel.text = "Неверный логин или пароль"
        unsuccessLoginLabel.textAlignment = .center
        unsuccessLoginLabel.textColor = UIColor.error
        unsuccessLoginLabel.adjustsFontSizeToFitWidth = true
        unsuccessLoginLabel.isHidden = true
        unsuccessLoginLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            unsuccessLoginLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
            unsuccessLoginLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            unsuccessLoginLabel.bottomAnchor.constraint(equalTo: stackView.topAnchor, constant: -Margins.single)
        ])
    }
    
    private func errorTextField(_ textField: UITextField, isError: Bool) {
        if isError {
            textField.layer.cornerRadius = 5
            textField.layer.borderWidth = 1
            textField.layer.borderColor = UIColor.error?.cgColor
        } else {
            textField.layer.borderColor = UIColor.clear.cgColor
            textField.borderStyle = .roundedRect
        }
    }
}
