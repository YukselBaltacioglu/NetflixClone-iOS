//
//  RegisterViewController.swift
//  Netflix Clone
//
//  Created by Yüksel Baltacıoğlu on 16.11.2023.
//

import UIKit

class RegisterViewController: UIViewController {

    private let emailField = CustomTextField(fieldType: .email)
    private let passwordField = CustomTextField(fieldType: .password)
    private let passwordConfirmField = CustomTextField(fieldType: .password)
    
    private let signUpButton = CustomButton(title: "Sign Up", hasBackground: true, fontSize: CustomButton.FontSize.register)
    private let rememberButton = CustomButton(title: "Remember my login", fontSize: CustomButton.FontSize.remember)
    private let goToSignInButton = CustomButton(title: "Sign In.", fontSize: CustomButton.FontSize.register)
    
    private let textField: UILabel = {
        let labelView = UILabel()
        labelView.text = "Already on Netflix?"
        labelView.textColor = .gray
        labelView.font =  .systemFont(ofSize: 16, weight: .regular)
        
        return labelView
    }()
    
    private let logoView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "netflixLogo")
        
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        
        self.signUpButton.addTarget(self, action: #selector(signUpTapped), for: .touchUpInside)
        self.goToSignInButton.addTarget(self, action: #selector(signInTapped), for: .touchUpInside)
        self.rememberButton.addTarget(self, action: #selector(rememberTapped), for: .touchUpInside)
        setupUI()
    }
    
    
    @objc private func rememberTapped() {
        self.rememberButton.isSelected.toggle()
        
    }
    @objc private func signUpTapped() {
        let registerUserRequest = UserRegisterRequest(email: self.emailField.text ?? "", password: self.passwordField.text ?? "", confirmPassword: self.passwordConfirmField.text ?? "")
        
        // Email check
        if !Validator.isValidEmail(with: registerUserRequest.email) {
            AlertManager.showValidEmailAlert(on: self)
            return
        }
        
        // Password check
        if !Validator.isPasswordValid(with: registerUserRequest.password) {
            AlertManager.showValidPasswordAlert(on: self)
            return
        }
        
        // Password match check
        if registerUserRequest.confirmPassword != registerUserRequest.password {
            AlertManager.showUnmatchPasswordErrorAlert(on: self)
            return
        }
        
        AuthService.shared.registerUser(with: registerUserRequest) { [weak self] wasRegistered, error in
            guard let self = self else {return}
            
            if let error = error {
                AlertManager.showRegistrationErrorAlert(on: self, with: error)
                return
            }
            if wasRegistered {
                if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate {
                    sceneDelegate.checkAuth()
                }
            }
            else {
                AlertManager.showRegistrationErrorAlert(on: self)
            }
            
        }
        
    }
    @objc private func signInTapped() {
        let vc = LoginViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func setupUI() {
        self.view.addSubview(emailField)
        self.view.addSubview(logoView)
        self.view.addSubview(passwordField)
        self.view.addSubview(passwordConfirmField)
        self.view.addSubview(signUpButton)
        self.view.addSubview(rememberButton)
        self.view.addSubview(goToSignInButton)
        self.view.addSubview(textField)

        
        self.emailField.translatesAutoresizingMaskIntoConstraints = false
        self.logoView.translatesAutoresizingMaskIntoConstraints = false
        self.passwordField.translatesAutoresizingMaskIntoConstraints = false
        self.passwordConfirmField.translatesAutoresizingMaskIntoConstraints = false
        self.signUpButton.translatesAutoresizingMaskIntoConstraints = false
        self.rememberButton.translatesAutoresizingMaskIntoConstraints = false
        self.goToSignInButton.translatesAutoresizingMaskIntoConstraints = false
        self.textField.translatesAutoresizingMaskIntoConstraints = false
        
        let imageConstraints = [
            self.logoView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.logoView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 170)
        ]
        
        let emailConstraints = [
            self.emailField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 50),
            self.emailField.topAnchor.constraint(equalTo: self.logoView.bottomAnchor, constant: 50),
            self.emailField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.emailField.heightAnchor.constraint(equalToConstant: 55),
            self.emailField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -50)
        ]
        
        let passwordConstraints = [
            self.passwordField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 50),
            self.passwordField.topAnchor.constraint(equalTo: self.emailField.bottomAnchor, constant: 12),
            self.passwordField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.passwordField.heightAnchor.constraint(equalToConstant: 55),
            self.passwordField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -50)
        ]
        
        let passwordConfirmConstraints = [
            self.passwordConfirmField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 50),
            self.passwordConfirmField.topAnchor.constraint(equalTo: self.passwordField.bottomAnchor, constant: 12),
            self.passwordConfirmField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.passwordConfirmField.heightAnchor.constraint(equalToConstant: 55),
            self.passwordConfirmField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -50)
        ]
        passwordConfirmField.placeholder = "Confirm Password"
        
        
        let signButtonConstraints = [
            self.signUpButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 50),
            self.signUpButton.topAnchor.constraint(equalTo: passwordConfirmField.bottomAnchor, constant: 40),
            self.signUpButton.heightAnchor.constraint(equalToConstant: 55),
            self.signUpButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -50)
            
        ]
        
        let rememberButtonConstraints = [
            self.rememberButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 70),
            self.rememberButton.topAnchor.constraint(equalTo: signUpButton.bottomAnchor, constant: 25),
            self.rememberButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.rememberButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -70)
            
        ]
        
        let randomTextConstraints = [
            self.textField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 100),
            self.textField.topAnchor.constraint(equalTo: rememberButton.bottomAnchor, constant: 25),
        ]
        
        let goToSignConstraints = [
            self.goToSignInButton.leadingAnchor.constraint(equalTo: textField.trailingAnchor, constant: 5),
            self.goToSignInButton.centerYAnchor.constraint(equalTo: textField.centerYAnchor)
        ]
        
        NSLayoutConstraint.activate(imageConstraints)
        NSLayoutConstraint.activate(emailConstraints)
        NSLayoutConstraint.activate(passwordConstraints)
        NSLayoutConstraint.activate(passwordConfirmConstraints)
        NSLayoutConstraint.activate(signButtonConstraints)
        NSLayoutConstraint.activate(rememberButtonConstraints)
        NSLayoutConstraint.activate(randomTextConstraints)
        NSLayoutConstraint.activate(goToSignConstraints)
        
    }


}
