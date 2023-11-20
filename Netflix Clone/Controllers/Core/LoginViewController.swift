//
//  LoginViewController.swift
//  Netflix Clone
//
//  Created by Yüksel Baltacıoğlu on 16.11.2023.
//

import UIKit

class LoginViewController: UIViewController {

    
    private let headerView = AuthHeaderUIView()
    
    private let emailField = CustomTextField(fieldType: .email)
    private let passwordField = CustomTextField(fieldType: .password)
    
    private let signInButton = CustomButton(title: "Sign In", hasBackground: true, fontSize: CustomButton.FontSize.register)
    private let registerButton = CustomButton(title: "Sign up now.", fontSize: CustomButton.FontSize.signIn)
    private let rememberButton = CustomButton(title: "Remember me", fontSize: CustomButton.FontSize.remember)
    
    private let textField: UILabel = {
        let labelView = UILabel()
        labelView.text = "New to Netflix?"
        labelView.textColor = .gray
        labelView.font =  .systemFont(ofSize: 16, weight: .regular)
        labelView.translatesAutoresizingMaskIntoConstraints = false
        
        return labelView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        self.signInButton.addTarget(self, action: #selector(signInTapped), for: .touchUpInside)
        self.registerButton.addTarget(self, action: #selector(registerTapped), for: .touchUpInside)
        self.rememberButton.addTarget(self, action: #selector(rememberTapped), for: .touchUpInside)
        setupUI()
    }
    
    @objc private func rememberTapped() {
        self.rememberButton.isSelected.toggle()
        
    }
    @objc private func signInTapped() {
        let loginRequest = UserRequest(email: self.emailField.text ?? "", password: self.passwordField.text ?? "")
        
        // Email check
        if !Validator.isValidEmail(with: loginRequest.email) {
            AlertManager.showValidEmailAlert(on: self)
            return
        }
        
        // Password check
        if !Validator.isPasswordValid(with: loginRequest.password) {
            AlertManager.showValidPasswordAlert(on: self)
            return
        }
        
        

        
        
        AuthService.shared.signIn(with: loginRequest) { [weak self] error in
            guard let self = self else {return}
            if let error = error {
                AlertManager.showSignInErrorAlert(on: self, with: error)
                return
            }
//            else {
//                AlertManager.showSignInErrorAlert(on: self)
//                return
//            }
            if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate {
                sceneDelegate.checkAuth()
            }
        }
        
    }
    @objc private func registerTapped() {
        let vc = RegisterViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func setupUI() {
        self.view.addSubview(headerView)
        self.view.addSubview(emailField)
        self.view.addSubview(passwordField)
        self.view.addSubview(signInButton)
        self.view.addSubview(registerButton)
        self.view.addSubview(textField)
        self.view.addSubview(rememberButton)
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        emailField.translatesAutoresizingMaskIntoConstraints = false
        passwordField.translatesAutoresizingMaskIntoConstraints = false
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        rememberButton.translatesAutoresizingMaskIntoConstraints = false
        
        
        let headerConstraints = [
            self.headerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.headerView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.headerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.headerView.heightAnchor.constraint(equalToConstant: 300)
        ]
        
        let emailConstraints = [
            self.emailField.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 17),
            self.emailField.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 12),
            self.emailField.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            self.emailField.heightAnchor.constraint(equalToConstant: 55),
            self.emailField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -17)
        ]
        
        let passwordConstraints = [
            self.passwordField.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 17),
            self.passwordField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 16),
            self.passwordField.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            self.passwordField.heightAnchor.constraint(equalToConstant: 55),
            self.passwordField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -17)
        ]
        
        let signButtonConstraints = [
            self.signInButton.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 17),
            self.signInButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 40),
            self.signInButton.heightAnchor.constraint(equalToConstant: 55),
            self.signInButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -17)
            
        ]
        
        let randomTextConstraints = [
            self.textField.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 17),
            self.textField.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 200)
        ]
        
        let registerConstraints = [
            self.registerButton.leadingAnchor.constraint(equalTo: textField.trailingAnchor, constant: 5),
            self.registerButton.centerYAnchor.constraint(equalTo: textField.centerYAnchor)
        ]
        
        let rememberButtonConstraints = [
            self.rememberButton.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 17),
            self.rememberButton.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 10)
        ]
        
        
        NSLayoutConstraint.activate(headerConstraints)
        NSLayoutConstraint.activate(emailConstraints)
        NSLayoutConstraint.activate(passwordConstraints)
        NSLayoutConstraint.activate(signButtonConstraints)
        NSLayoutConstraint.activate(randomTextConstraints)
        NSLayoutConstraint.activate(registerConstraints)
        NSLayoutConstraint.activate(rememberButtonConstraints)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }

}
