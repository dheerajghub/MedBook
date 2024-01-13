//
//  LoginViewController.swift
//  MedBook
//
//  Created by Dheeraj Kumar Sharma on 21/12/23.
//

import UIKit

class LoginViewController: UIViewController {

    // MARK: PROPERTIES -
    
    let viewModel = AuthViewModel()
    
    lazy var backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.tintColor = .white
        button.tapFeedBack()
        button.backgroundColor = .black
        button.layer.cornerRadius = 17.5
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let headerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Welcome,\nLogin to continue"
        label.textAlignment = .left
        label.textColor = .black
        label.font = .systemFont(ofSize: 25, weight: .bold)
        label.numberOfLines = 2
        return label
    }()
    
    let emailTextCoverView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        view.backgroundColor = .lightGray.withAlphaComponent(0.1)
        return view
    }()
    
    lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        textField.attributedPlaceholder = NSAttributedString(
            string: "Email",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        )
        
        textField.autocorrectionType = .no
        textField.textColor = .black
        textField.tintColor = .black
        textField.autocapitalizationType = .none
        
        textField.addTarget(self, action: #selector(emailTextFieldDidChange(_:)), for: .editingChanged)
        return textField
    }()
    
    
    let passwordTextCoverView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 10
        view.backgroundColor = .lightGray.withAlphaComponent(0.1)
        return view
    }()
    
    lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        textField.attributedPlaceholder = NSAttributedString(
            string: "Password",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        )
        
        textField.textColor = .black
        textField.tintColor = .black
        textField.isSecureTextEntry = true
        textField.addTarget(self, action: #selector(passwordTextFieldDidChange(_:)), for: .editingChanged)
        return textField
    }()
    
    lazy var showButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "eye.slash.fill"), for: .normal)
        button.tapFeedBack()
        button.addTarget(self, action: #selector(showPasswordButton), for: .touchUpInside)
        button.tintColor = .black
        return button
    }()
    
    lazy var loginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Login", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        button.layer.cornerRadius = 30
        button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .semibold)
        button.tapFeedBack()
        return button
    }()
    
    // MARK: MAIN -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        setUpConstraints()
        hideKeyboardWhenTappedAround()
    }
    
    // MARK: FUNCTIONS -
    
    func setUpViews(){
        view.backgroundColor = .white
        view.addSubview(backButton)
        view.addSubview(headerLabel)
        
        view.addSubview(emailTextCoverView)
        emailTextCoverView.addSubview(emailTextField)
        
        view.addSubview(passwordTextCoverView)
        passwordTextCoverView.addSubview(passwordTextField)
        passwordTextCoverView.addSubview(showButton)
        
        view.addSubview(loginButton)
        
    }
    
    func setUpConstraints(){
        NSLayoutConstraint.activate([
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            backButton.widthAnchor.constraint(equalToConstant: 35),
            backButton.heightAnchor.constraint(equalToConstant: 35),
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            
            headerLabel.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 30),
            headerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            emailTextCoverView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            emailTextCoverView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            emailTextCoverView.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 50),
            emailTextCoverView.heightAnchor.constraint(equalToConstant: 60),
            
            emailTextField.leadingAnchor.constraint(equalTo: emailTextCoverView.leadingAnchor, constant: 15),
            emailTextField.trailingAnchor.constraint(equalTo: emailTextCoverView.trailingAnchor, constant: -15),
            emailTextField.centerYAnchor.constraint(equalTo: emailTextCoverView.centerYAnchor),
            
            
            passwordTextCoverView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            passwordTextCoverView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            passwordTextCoverView.topAnchor.constraint(equalTo: emailTextCoverView.bottomAnchor, constant: 15),
            passwordTextCoverView.heightAnchor.constraint(equalToConstant: 60),
            
            passwordTextField.leadingAnchor.constraint(equalTo: passwordTextCoverView.leadingAnchor, constant: 15),
            passwordTextField.trailingAnchor.constraint(equalTo: passwordTextCoverView.trailingAnchor, constant: -15),
            passwordTextField.centerYAnchor.constraint(equalTo: passwordTextCoverView.centerYAnchor),
            
            showButton.trailingAnchor.constraint(equalTo: passwordTextCoverView.trailingAnchor, constant: -15),
            showButton.centerYAnchor.constraint(equalTo: passwordTextCoverView.centerYAnchor),
            showButton.widthAnchor.constraint(equalToConstant: 40),
            showButton.heightAnchor.constraint(equalToConstant: 40),
            
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            loginButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            loginButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    
    // MARK: ACTIONS -
    
    @objc func backButtonTapped(){
        self.dismiss(animated: true)
    }
    
    @objc func loginButtonTapped(){
        
        viewModel.loginUser { success, message in
            if success {
                self.showAlert("Success", message: message ?? "", actionButtonName: "Let's go") { _ in
                    // redirect user to listing page
                    let controller = HomeViewController()
                    controller.modalTransitionStyle = .crossDissolve
                    controller.modalPresentationStyle = .fullScreen
                    self.present(controller, animated: true)
                }
            } else {
                self.showAlert("Error", message: message ?? "") { _ in }
            }
        }
        
    }
    
    @objc func showPasswordButton(){
        viewModel.showPassword = !viewModel.showPassword
        
        if viewModel.showPassword {
            showButton.setImage(UIImage(systemName: "eye.fill"), for: .normal)
            showButton.tintColor = .black
            passwordTextField.isSecureTextEntry = false
        } else {
            showButton.setImage(UIImage(systemName: "eye.slash.fill"), for: .normal)
            showButton.tintColor = .black
            passwordTextField.isSecureTextEntry = true
        }
    }
    
    @objc func emailTextFieldDidChange(_ textField: UITextField) {
        
        let enteredText = textField.text ?? ""
        viewModel.email = enteredText
        
    }
    
    @objc func passwordTextFieldDidChange(_ textField: UITextField) {
        
        let enteredText = textField.text ?? ""
        viewModel.password = enteredText
        
    }


}
